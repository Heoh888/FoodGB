//
//  SideMenuView.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 27.10.2022.
//

import SwiftUI
import Kingfisher

struct SideMenuView: View {
    
    @Binding var selectedTap: String
    @Binding var user: User
    @Namespace var animation
    
    var authViewModel: AuthViewModel
    
    var body: some View {
        VStack(alignment: .leading,
               content: {

            if user.profileImageUrl == nil {
                Image("userImage")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 70, height: 70)
                    .padding(.top, 50)
            } else {
                KFImage(URL(string: user.profileImageUrl!))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 70, height: 70)
                    .clipped()
                    .cornerRadius(10)
                    .padding(.top, 50)
            }

            Text(user.userName)
                .font(.title2)
                .foregroundColor(.white)
                .fontWeight(.heavy)

            VStack(alignment: .leading, spacing: 10) {
                
                TapButtonMenu(image: "house",
                              title: "Home",
                              selectedTab: $selectedTap,
                              animation: animation)
                
                TapButtonMenu(image: "person.crop.circle",
                              title: "Profile",
                              selectedTab: $selectedTap,
                              animation: animation)
                
                TapButtonMenu(image: "cart",
                              title: "Orders",
                              selectedTab: $selectedTap,
                              animation: animation)
                
                TapButtonMenu(image: "tag",
                              title: "Offer and promo",
                              selectedTab: $selectedTap,
                              animation: animation)
                
                TapButtonMenu(image: "doc.text",
                              title: "Privacy policy",
                              selectedTab: $selectedTap,
                              animation: animation)
                
                TapButtonMenu(image: "shield.righthalf.filled",
                              title: "Security",
                              selectedTab: $selectedTap,
                              animation: animation)
            }
            .padding(.leading, -15)
            .padding(.top, 50)
            
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
