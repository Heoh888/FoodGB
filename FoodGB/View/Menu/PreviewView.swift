//
//  PreviewView.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 27.10.2022.
//

import SwiftUI

struct PreviewView: View {
    
    // MARK: - Properties
    @Binding var currentTab: TabBar
    @Binding var selrctedTap: String
    @Binding var user: User
    @Binding var buttonDisabled: Bool
    @ObservedObject var ordersViewModel: OrdersViewModel
    @StateObject var viewModel = ProfileViewModel()
    
    // MARK: - Initialisation
    init(currentTab: Binding<TabBar>, selrctedTap: Binding<String>,  user: Binding<User>, buttonDisabled: Binding<Bool>, ordersViewModel: OrdersViewModel) {
        UITabBar.appearance().isHidden = true
        self._currentTab = currentTab
        self._selrctedTap = selrctedTap
        self._user = user
        self._buttonDisabled = buttonDisabled
        self.ordersViewModel = ordersViewModel
    }
    
    // MARK: - Views
    var body: some View {
        TabView(selection: $selrctedTap) {

            MainPage(currentTab: $currentTab,
                     buttonDisabled: $buttonDisabled, user: $user,
                     ordersViewModel:  ordersViewModel)
                .tag("Main")

            ProfilleView(user: $user, viewModel: viewModel)
                .tag("Profile")

            HistoryView()
                .tag("Order history")

            PrivacyPolicy()
                .tag("Privacy policy")

            SecurityView()
                .tag("Security")
        }
        
    }
}
