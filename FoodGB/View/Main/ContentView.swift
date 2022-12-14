//
//  ContentView.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 19.10.2022.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
    @State var starteed = true
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    // MARK: - Views
    var body: some View {
        VStack {
            Group {
                if viewModel.userSession == nil {
                    if starteed {
                        StartView(starteed: $starteed)
                    } else {
                        AuthView()
                    }
                } else {
                    if let user = viewModel.currentUser {
                        MenuView(user: user)
                    }
                }
            }
        }
    }
}

