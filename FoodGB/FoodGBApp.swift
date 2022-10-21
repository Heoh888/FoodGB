//
//  FoodGBApp.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 19.10.2022.
//

import SwiftUI
import Firebase

@main
struct FoodGBApp: App {
    
    // MARK: - Properties
    let persistenceController = PersistenceController.shared
    
    // MARK: - Initialisation
    init() {
        FirebaseApp.configure()
    }
    
    // MARK: - Views
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(AuthViewModel.shared)
        }
    }
}
