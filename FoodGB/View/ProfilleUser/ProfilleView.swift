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
    @Binding var user: User
    
    @StateObject var viewModel: ProfileViewModel
    
    // MARK: - Views
    var body: some View {
        ZStack(alignment: .leading) {
            Color.gray.opacity(0.15)
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                
                Text("My profile")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 70)
                
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
                        UpdateProfilleView(name: user.userName,
                                           id: user.id!,
                                           phone: user.phone ?? "",
                                           address: user.address ?? "",
                                           userImage: viewModel.userImage!,
                                           user: $user,
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
        VStack {
            ZStack(alignment: .top) {
                Rectangle()
                    .fill(Color.white)
                    .frame(height: 300)
                    .cornerRadius(20)
                HStack(alignment: .top) {
                    if let image = viewModel.userImage {
                        image
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
            Spacer()
        }
    }
}
