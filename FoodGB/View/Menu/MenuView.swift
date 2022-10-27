//
//  MainMenuView.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 26.10.2022.
//

import SwiftUI

struct MenuView: View {
    
    @State var selectedTap = "Home"
    @State var showMainMenu = false
    
    var authViewModel: AuthViewModel
    
    @State var user: User
    
    var body: some View {
        ZStack {
            Color("MainColor")
                .ignoresSafeArea()

            SideMenuView(selectedTap: $selectedTap,
                         user: $user,
                         authViewModel: authViewModel)
            
            
            ZStack {
                
                Color.white
                    .opacity(0.3)
                    .cornerRadius(showMainMenu ? 50 : 0)
                    .offset(x: showMainMenu ? -35 : 0, y: showMainMenu ? 70 : 0)
                    .padding(.vertical, 30)
                
                PreviewView(selrctedTap: $selectedTap, user: $user, authViewModel: authViewModel)
                    .cornerRadius(showMainMenu ? 50 : 0)
                    .onTapGesture {
                        if showMainMenu == true {
                            withAnimation(.spring()) {
                                showMainMenu.toggle()
                            }
                        }
                    }
            }
            .scaleEffect(showMainMenu ? 0.65 : 1)
            .offset(x: showMainMenu ? getRect().width - 200 : 0)
            .ignoresSafeArea()
            .overlay(
                Button(action: {
                    withAnimation(.spring()) {
                        showMainMenu.toggle()
                    }
                }, label: {
                    VStack(alignment: .leading, spacing: 5) {
                        Capsule()
                            .fill(showMainMenu ? Color.white : Color.primary)
                            .frame(width: 30, height: 3)
                            .rotationEffect(.init(degrees: showMainMenu ? -50 : 0))
                            .offset(x: showMainMenu ? 0 : 0,
                                    y: showMainMenu ? 8 : 0)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            if !showMainMenu {
                                Capsule()
                                    .fill(showMainMenu ? Color.white : Color.primary)
                                    .frame(width: 20, height: 3)
                            }
                            Capsule()
                                .fill(showMainMenu ? Color.white : Color.primary)
                                .frame(width: 30, height: 3)
                        }
                        .rotationEffect(.init(degrees: showMainMenu ? 50 : 0))
                        
                    }
                })
                .padding(),
                alignment: .topLeading)
        }
    }
}
