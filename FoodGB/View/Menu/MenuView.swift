//
//  MainMenuView.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 26.10.2022.
//

import SwiftUI

struct MenuView: View {
    
    // MARK: - Properties
    @State var currentTab: TabBar = .homePage
    @State var selectedTap = "Home"
    @State var showMainMenu = false
    @State var buttonDisabled = false
    @State var user: User
    @State var searchActivated = false
    @StateObject var ordersViewModel = OrdersViewModel()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    // MARK: - NavigationBar
    var btnBack : some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.backward")
                .scaleEffect(0.8)
                .foregroundColor(.black)
        }
        .padding(.leading, 25)
    }
    
    // MARK: - Views
    var body: some View {
        NavigationView {
            ZStack {
                Color("MainColor")
                    .ignoresSafeArea()
                
                SideMenuView(selectedTap: $selectedTap,
                             user: $user)
                
                ZStack {
                    Color.white
                        .opacity(0.3)
                        .cornerRadius(showMainMenu ? 50 : 0)
                        .offset(x: showMainMenu ? -35 : 0, y: showMainMenu ? 70 : 0)
                        .padding(.vertical, 30)
                    
                    PreviewView(currentTab: $currentTab,
                                selrctedTap: $selectedTap,
                                user: $user,
                                searchActivated: $searchActivated,
                                buttonDisabled: $buttonDisabled,
                                ordersViewModel: ordersViewModel)
                    .cornerRadius(showMainMenu ? 50 : 0)
                    .onTapGesture {
                        if showMainMenu == true {
                            withAnimation(.spring()) {
                                showMainMenu.toggle()
                                buttonDisabled.toggle()
                            }
                        }
                    }
                }
                .scaleEffect(showMainMenu ? 0.65 : 1)
                .offset(x: showMainMenu ? getRect().width - 200 : 0)
                .ignoresSafeArea()
                .overlay(
                    HStack{
                        if !searchActivated {
                            Button(action: {
                                withAnimation(.spring()) {
                                    showMainMenu.toggle()
                                    buttonDisabled.toggle()
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
                            .padding()
                            
                            Spacer()
                            if !showMainMenu {
                                NavigationLink {
                                    OrdersView(ordersViewModel: ordersViewModel,
                                               selrctedTap: $selectedTap,
                                               currentTab: $currentTab)
                                    .navigationBarTitle(Text("Cart"))
                                } label: {
                                    Image(systemName: "cart")
                                        .font(.system(.title2))
                                        .foregroundColor(.black)
                                        .padding(.trailing)
                                }
                                
                            }
                        }
                    },
                    alignment: .topLeading)
            }
        }
    }
}
