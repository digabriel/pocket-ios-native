# CLAUDE.md

Guidance for AI assistants working in this repository.

## Project overview

**Pocket** is a native iOS personal-finance app, built as a learning/portfolio
project to practice **Swift 6, SwiftUI, Swift Concurrency, SwiftData, Swift
Testing, MVVM, and Clean Architecture**.

The codebase is deliberately split into small, independent **Swift Package
Manager modules** (under `Packages/`) that each follow the same layered
architecture. The Xcode app target (`Pocket/`) is a thin composition root that
wires the packages together.

- Bundle ID: `net.dimasgabriel.PocketApp`
- Deployment target: iOS 17+ (app target builds against iOS 18; packages
  declare `.iOS(.v17)` / `.macOS(.v14)`)
- Swift tools version: 6.0 (packages). App target `SWIFT_VERSION = 5.0` build
  setting, but code is written in the Swift 6 concurrency style (`Sendable`,
  actors, `@MainActor`).

## Repository layout

```
Pocket.xcodeproj/          Main app Xcode project (target: Pocket)
Pocket/                    App composition root
  PocketApp.swift          @main entry; builds ModelContainer + packages
  MainTabBar/MainTabView   Root TabView (Overview / Budget / Wallets / Tools)
  Assets.xcassets          App-level assets (tab icons, app icon)
PocketTests/               App-level unit tests (Xcode target)
PocketUITests/             App-level UI tests (Xcode target)

Packages/                  Feature & shared SPM modules (the real code lives here)
  CommonDomain/            Shared domain primitives (Money, Currency, UseCase, ...)
  Styleguide/              Design system: Colors, Fonts, Dimensions, components
  Notifications/           Notifications feature module
  Onboarding/              Onboarding feature module
  Wallets/                 Wallets feature module (richest example)

DevApps/OnboardingApp/     Standalone Xcode app to develop the Onboarding module in isolation
Demos/NotificationsDemo/   Standalone Xcode app to demo the Notifications module
.scripts/pre-commit        Git pre-commit hook that runs `swiftlint --fix`
```

### Package dependency graph

```
CommonDomain   (no internal deps)
Styleguide     (no internal deps)
Notifications  -> Styleguide, CommonDomain, swift-log
Wallets        -> Styleguide, CommonDomain, swift-log (+ SwiftLint build plugin)
Onboarding     -> Styleguide, Notifications
```

External dependencies: `apple/swift-log` (pinned `1.6.1`) and
`SimplyDanny/SwiftLintPlugins` (pinned `0.55.1`, Wallets only).

## Architecture — Clean Architecture + MVVM

Every feature package is organized into three layers. **Wallets is the
canonical, most complete example — mirror it when adding features.**

```
Sources/<Module>/
  Domain/          Pure business logic, no SwiftUI / SwiftData
    Models/        Value types (e.g. Wallet, WalletCategory)
    UseCases/      One use case per business action
    Repositories/  Repository *protocols* (interfaces only)
    Mappers/       Optional domain mappers
  Infra/           Implementation details
    SwiftData/
      Models/        @Model persistence types (SwiftDataWallet, ...)
      Repositories/  @ModelActor repository implementations
  Presentation/    SwiftUI + view models
    <Feature>View.swift
    <Feature>View+ViewModel.swift
    Shared/, Utils/Previews/, PreviewContent/
  <Module>Package.swift   PackageConfigurator entry point (app-facing)
```

Dependency direction: **Presentation → Domain ← Infra**. Domain never imports
SwiftUI or SwiftData. Infra maps persistence models to domain models via
`toDomain()` / `init(domainModel:)` conversion methods.

### Key conventions

**Use cases** conform to the shared `UseCase` protocol
(`CommonDomain/UseCases/UseCase.swift`):

```swift
public protocol UseCase: Sendable {
    associatedtype Input
    associatedtype Output
    func execute(input: Input) async throws -> Output
}
```

- Define a per-use-case protocol (`GetWalletCategoriesProtocol: UseCase where
  Input == Void, Output == [WalletCategory]`) plus a concrete `...UseCase`
  final class. View models depend on the protocol (`any GetWalletCategoriesProtocol`)
  so tests/previews can inject fakes.
- Use `Void` for `Input`/`Output` when there is no payload.

**Repositories**: protocol lives in `Domain/Repositories`; SwiftData
implementation lives in `Infra/SwiftData/Repositories` as an `@ModelActor
actor`. Note: `#Predicate` does not support enums here, so some filtering is
done in memory after `fetch` (see `SwiftDataWalletsRepository`).

**View models**: nested inside the View via extension, marked
`@MainActor @Observable final class ViewModel`. They receive a `Dependency`
struct (holding use-case protocols) through the initializer. Public views
expose a `public struct Dependency` with a `public init`.

```swift
extension WalletsMainView {
    @MainActor @Observable final class ViewModel {
        init(dependency: Dependency) { ... }
    }
}
public extension WalletsMainView {
    struct Dependency { let getWalletCategoriesUseCase: any GetWalletCategoriesProtocol; ... }
}
```

**Views** take a `Dependency` or a `ViewModel` in `init` and build state with
`@State private var viewModel`. Always provide a `#Preview` that injects
`*Preview` fakes from `Presentation/Utils/Previews` or `PreviewContent`.

**Package configurators**: each module exposes a top-level type conforming to
`PackageConfigurator` (`CommonDomain/Protocols/PackageConfigurator.swift`) with
`func setupData() async`. The app instantiates these in `PocketApp.init`,
passing the shared `ModelContainer`, and calls `setupData()` concurrently in a
`withTaskGroup` during launch. `SwiftUIWalletsPackage` is `@Observable` and
injected via `.environment(...)`; it exposes lazily-constructed use cases
through a nested `UseCases` struct.

**Dependency injection** is manual (no DI framework): factories
(`OnboardingUseCaseFactory`) or package `UseCases` structs build concrete use
cases and hand protocols to the presentation layer.

**Concurrency**: types crossing actor boundaries are `Sendable`; domain models
are `Sendable` value types; view models and `setupData` are `@MainActor`.
Prefer `async`/`await` and `withTaskGroup` over completion handlers.

**Money & currency**: use `CommonDomain.Money` (a `Decimal` amount +
`Currency`). Never use `Double` for money. Arithmetic across currencies throws
`MoneyError`. Format with `Money.formatted()`.

## Styleguide (design system)

Import `Styleguide` and use its tokens instead of hardcoded values:

- **Colors**: `Color.regular.white`, `Color.background.darkPink`, etc.
  (namespaced structs on `Color`). Assets live in
  `Styleguide/Resources/Colors.xcassets`.
- **Fonts**: `Font.text.small`, `Font.title.largerRounded`, `Font.button.regular`.
- **Spacing**: `Dimensions.shared.<name>` (e.g. `.eight` == 20pt). Use these
  named steps rather than raw CGFloat literals.
- **Components**: reusable views like `CircularTitledButton`, `CapsuleButton`,
  `CurrencyTextField`, `PageIndicator`, `Box`, `Toggle`,
  `StatefulPreviewWrapper` (handy for previews of bindings).

## Localization

User-facing strings use `String(localized: "...")`. Each feature module owns a
`Localizable.xcstrings` catalog. Packages that ship strings set
`defaultLocalization: "en"` in `Package.swift`.

## Testing

Tests use the **Swift Testing** framework (`import Testing`, `@Test`,
`#expect`) — **not** XCTest — and live in each package's `Tests/` directory.

- Test structs are often `@MainActor struct SomethingTests`.
- Use a `makeSut()` helper to build the system under test with in-memory fakes.
- Test doubles live under `Tests/.../Utils/Repositories` and follow patterns:
  `InMemory*Repository` (working fake), `*RepositoryMock` / `*RepositorySpy`
  (assertion doubles), and `*+Mock` model builders (e.g. `Wallet.mock(...)`).
- Inject fake use cases/repositories through the `Dependency` structs — never
  hit real SwiftData in unit tests.

Example shape:

```swift
@Test func shouldBuildItemsOutput() async throws {
    try await walletCategoriesRepository.create(category: .savings)
    let sut = makeSut()
    await sut.refresh()
    #expect(sut.items.count == 2)
}
```

## Build & test commands

There is no CI config or Makefile in the repo; use Xcode / `xcodebuild`. The
app scheme/target is **Pocket**.

```bash
# Build the app
xcodebuild -project Pocket.xcodeproj -scheme Pocket \
  -destination 'platform=iOS Simulator,name=iPhone 16' build

# Run app-level tests (PocketTests / PocketUITests)
xcodebuild -project Pocket.xcodeproj -scheme Pocket \
  -destination 'platform=iOS Simulator,name=iPhone 16' test

# Build/test an individual package (fast iteration, no simulator needed for logic)
cd Packages/Wallets && swift build
cd Packages/Wallets && swift test
```

The standalone `DevApps/OnboardingApp` and `Demos/NotificationsDemo` Xcode
projects let you build a single feature module in isolation — useful when
iterating on Onboarding or Notifications without launching the full app.

> Note: this repo is normally built on macOS with Xcode. In a Linux/container
> session you can read and reason about the code, but `xcodebuild` and the iOS
> SDK are unavailable. `swift build`/`swift test` on individual packages may
> also fail if they depend on UIKit/SwiftUI-only APIs.

## Linting

**SwiftLint** enforces style. It runs two ways:

1. **Build-tool plugin** in the Wallets package (`SwiftLintBuildToolPlugin`,
   pinned `0.55.1`) — lints on every build of that target.
2. **Git pre-commit hook** at `.scripts/pre-commit` runs `swiftlint --fix` on
   staged files and blocks the commit on unfixable violations. Enable it with
   `git config core.hooksPath .scripts` (or symlink into `.git/hooks`).

Run `swiftlint --fix` before committing. There is no committed
`.swiftlint.yml`, so default rules apply.

## Conventions for making changes

- **Add a feature** → create/extend a package under `Packages/` following the
  Wallets layer structure; keep Domain free of SwiftUI/SwiftData.
- **New persisted model** → add a `@Model` type under
  `Infra/SwiftData/Models`, provide `toDomain()`/`init(domainModel:)`, register
  it in the `ModelContainer(for:)` list in `PocketApp.init`, and seed defaults
  in the package's `setupData()`.
- **New screen** → View + nested `@MainActor @Observable ViewModel` + a
  `Dependency` struct; expose it publicly if the app composes it; add a
  `#Preview` with fakes.
- **New business rule** → a `UseCase` (protocol + concrete class) in
  `Domain/UseCases`, wired through a factory or the package's `UseCases`.
- Match existing file headers, naming (`<Feature>View`, `<Feature>View+ViewModel`,
  `SwiftData<Name>`, `*Protocol`, `*UseCase`), and folder layout.
- Use Styleguide tokens, `Money` for currency, and `String(localized:)` for
  copy.

## Git workflow

- Default branch: `main`.
- Commit messages are short, imperative, and descriptive (see `git log`), e.g.
  "Add save button to create wallet overview".
- The pre-commit hook auto-fixes lint; keep commits lint-clean.
