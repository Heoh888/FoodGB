//
//  ProfilleView.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 19.10.2022.
//

import SwiftUI
import Kingfisher

struct ProfilleView: View {
    
    // MARK: - Properties
    @State var change = false
    @State var user: User
    
    @ObservedObject var viewModel = ProfileViewModel()
    
    var authViewModel: AuthViewModel
    
    // MARK: - Views
    var body: some View {
        ZStack(alignment: .leading) {
            Color.gray.opacity(0.15)
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Button {
                    authViewModel.signout()
                } label: {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 15, height: 15)
                        .padding(.top)
                        .padding(.bottom, 40.0)
                }
                
                Text("My profile")
                    .font(.system(size: 34, weight: .semibold))
                    .padding(.leading)
                
                HStack {
                    Text("Personal details")
                        .font(.system(size: 18, weight: .semibold))
                    
                    Spacer()
                    
                    Button {
                        change.toggle()
                    } label: {
                        Text("change")
                            .font(.system(size: 18, weight: .semibold))
                            .fontWeight(.light)
                            .foregroundColor(Color("MainColor"))
                    }
                    .sheet(isPresented: $change) {
                        UpdateProfilleView(user: $user,
                                           name: user.userName,
                                           urlImage: authViewModel.currentUser?.profileImageUrl,
                                           change: $change,
                                           viewModel: viewModel)
                    }
                }
                .padding(.top)
                
                tableProfileData()
                Spacer()
            }
            .padding(.horizontal, 30.0)
        }
    }
    
    // MARK: - ViewBuilder
    @ViewBuilder
    func tableProfileData() -> some View {
        ZStack {
            GeometryReader { geometry in
                Rectangle()
                    .fill(Color.white)
                    .cornerRadius(20)
                    .frame(height: geometry.size.height)
                
                HStack(alignment: .top) {
                    if user.profileImageUrl == nil {
                        Image("userImage")
                            .padding([.top, .leading])
                    } else {
                        KFImage(URL(string: user.profileImageUrl!))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 91, height: 100)
                            .clipped()
                            .cornerRadius(20)
                            .padding([.top, .leading])
                    }
                    ProfilleTextView(user: user)
                    .padding([.top, .leading, .trailing])
                }
            }
        }
    }
}
