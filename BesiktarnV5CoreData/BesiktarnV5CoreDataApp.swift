//
//  BesiktarnV5CoreDataApp.swift
//  BesiktarnV5CoreData
//
//  Created by Patrik Korab on 2022-11-17.
//

import SwiftUI

@main
struct BesiktarnV5CoreDataApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
