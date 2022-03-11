//
//  Bored_AppApp.swift
//  Bored App
//
//  Created by Felipe Marques Ramos on 3/11/22.
//

import SwiftUI

@main
struct Bored_AppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
