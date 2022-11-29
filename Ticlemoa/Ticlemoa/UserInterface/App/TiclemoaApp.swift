//
//  TiclemoaApp.swift
//  Ticlemoa
//
//  Created by 김우성 on 2022/11/28.
//

import SwiftUI

@main
struct TiclemoaApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
//            HomeView()
            MainTabView()
                .accentColor(Color.mainGreen)
        }
    }
}
