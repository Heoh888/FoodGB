//
//  SideMenuView.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 27.10.2022.
//

import SwiftUI
import Kingfisher

struct SideMenuView: View {
    
    // MARK: - Properties
    @Binding var selectedTap: String
    @Binding var user: User
    @Namespace var animation
    @EnvironmentObject var authViewModel: AuthViewModel
    
    // MARK: - Views
    var body: some View {
        VStack(alignment: .leading,
               content: {

            VStack(alignment: .leading, spacing: 10) {
                TapButtonMenu(image: "house",
                              title: "Home",
                              animation: animation,
                              selectedTab: $selectedTap)
                
                TapButtonMenu(image: "person.crop.circle",
                              title: "Profile",
                              animation: animation,
                              selectedTab: $selectedTap)
                
                TapButtonMenu(image: "cart",
                              title: "Orders",
                              animation: animation,
                              selectedTab: $selectedTap)
                
                TapButtonMenu(image: "tag",
                              title: "Offer and promo",
                              animation: animation,
                              selectedTab: $selectedTap)
                
                TapButtonMenu(image: "doc.text",
                              title: "Privacy policy",
                              animation: animation,
                              selectedTab: $selectedTap)

                TapButtonMenu(image: "shield.righthalf.filled",
                              title: "Security",
                              animation: animation,
                              selectedTab: $selectedTap)
            }
            .padding(.leading, -15)
            .padding(.top, 100)
            Spacer()
            
            Button(action: {
                authViewModel.signout()
            }, label: {
                HStack(spacing: 10) {
                    Image(systemName: "rectangle.righthalf.inset.filled.arrow.right")
                        .font(.title2)
                        .frame(width: 30)
                    
                    Text("Sign-out")
                        .fontWeight(.semibold)
                }
                .foregroundColor(.white)
                .padding(.vertical, 12)
                .padding(.horizontal, 20)
            })
            .padding(.leading, -15)
        })
        .padding()
        .frame(maxWidth: .infinity,
               maxHeight: .infinity,
               alignment: .topLeading)
    }
}
