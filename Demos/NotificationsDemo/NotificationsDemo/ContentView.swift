//
//  ContentView.swift
//  NotificationsDemo
//
//  Created by Dimas Gabriel on 6/29/24.
//

import SwiftUI
import Notifications
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @State private var notificationsStatus: NotificationRegistrationStatus = .notDetermined

    var body: some View {
        VStack(spacing: 40) {
            NotificationBucketTogglerList(modelContext: context, keys: NotificationBucket.Key.allCases)

            VStack(spacing: 16) {
                Button {
                    requestNotifications()
                } label: {
                    Text("Request Notifications permissions")
                }

                HStack {
                    Text("Notification Status: ")
                    Text("\(notificationsStatus)")
                }
            }
        }
        .padding()
    }

    private func requestNotifications() {
        guard notificationsStatus == .notDetermined else { return }

        Task {
            let useCase = NotificationsUseCaseFactory.makeRegistrationUseCase()
            notificationsStatus = await useCase.execute(input: ())
        }
    }
}

#Preview {
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: NotificationBucket.self, configurations: configuration)

    for key in NotificationBucket.Key.allCases {
        container.mainContext.insert(NotificationBucket(key: key, isEnabled: false))
    }

    return ContentView()
        .modelContainer(container)
}
