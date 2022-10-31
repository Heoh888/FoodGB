//
//  PreviewView.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 27.10.2022.
//

import SwiftUI

struct PreviewView: View {
    
    @Binding var selrctedTap: String
    @Binding var user: User
    @Binding var buttonDisabled: Bool
    @Namespace var animation
    
    var authViewModel: AuthViewModel
    
    init(selrctedTap: Binding<String>,  user: Binding<User>, buttonDisabled: Binding<Bool>, authViewModel: AuthViewModel) {
        self._selrctedTap = selrctedTap
        self._user = user
        self._buttonDisabled = buttonDisabled
        self.authViewModel = authViewModel
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        TabView(selection: $selrctedTap) {
            
            HomePageView(buttonDisabled: $buttonDisabled, animation: animation)
                .tag("Home")
            
            ProfilleView(user: $user, authViewModel: authViewModel)
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
