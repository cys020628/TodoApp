//
//  TodoAppApp.swift
//  TodoApp
//
//  Created by 영석 on 3/20/25.
//

import SwiftUI
import SwiftData

@main
struct TodoAppApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Todo.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        
        .modelContainer(sharedModelContainer)
    }
}
