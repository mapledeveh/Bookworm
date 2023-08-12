//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Alex Nguyen on 2023-06-28.
//

import SwiftUI

@main
struct BookwormApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
