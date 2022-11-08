//
//  PreviewView.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 27.10.2022.
//

import SwiftUI

struct PreviewView: View {
    
    // MARK: - Properties
    @Binding var selrctedTap: String
    @Binding var user: User
    @Binding var buttonDisabled: Bool
    @Namespace var animation
    @StateObject var viewModel = ProfileViewModel()
    
    // MARK: - Initialisation
    init(selrctedTap: Binding<String>,  user: Binding<User>, buttonDisabled: Binding<Bool>) {
        UITabBar.appearance().isHidden = true
        self._selrctedTap = selrctedTap
        self._user = user
        self._buttonDisabled = buttonDisabled
    }
    
    // MARK: - Views
    var body: some View {
        TabView(selection: $selrctedTap) {

            HomePageView(buttonDisabled: $buttonDisabled, animation: animation)
                .tag("Home")

            ProfilleView(user: $user, viewModel: viewModel)
                .tag("Profile")

            OrdersView()
                .tag("Orders")

            PromoView()
                .tag("Offer and promo")

            PrivacyPolicy()
                .tag("Privacy policy")

            SecurityView()
                .tag("Security")
        }
        
    }
}
