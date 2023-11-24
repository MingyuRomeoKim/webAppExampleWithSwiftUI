//
//  webAppApp.swift
//  webApp
//
//  Created by mingyukim on 10/30/23.
//

import SwiftUI

@main
struct webAppApp: App {
    let persistenceController = PersistenceController.shared
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
