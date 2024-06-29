//
//  NotificationsDemoApp.swift
//  NotificationsDemo
//
//  Created by Dimas Gabriel on 6/29/24.
//

import SwiftUI
import Notifications
import SwiftData

@main
struct NotificationsDemoApp: App {
    let container: ModelContainer

    init() {
        do {
            container = try ModelContainer(for: NotificationBucket.self)

            Task {
                await NotificationPackage()?.setupData()
            }
        } catch {
            fatalError("Failed to create ModelContainer.")
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
    }
}
