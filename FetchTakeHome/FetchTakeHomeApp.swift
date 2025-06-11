//
//  FetchTakeHomeApp.swift
//  FetchTakeHome
//
//  Created by Khurram Nawaz on 6/11/25.
//

import SwiftUI

@main
struct FetchTakeHomeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
