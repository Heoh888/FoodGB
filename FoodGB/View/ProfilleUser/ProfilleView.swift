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
            Color("Background_2")
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Text("My profile")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 60)
                
                HStack {
                    Text("Personal details")
                        .font(.system(size: 18, weight: .semibold))
                    Spacer()
                    
                    Button {
                        change.toggle()
                    } label: {
                        Text("change")
                            .font(.system(size: 18, weight: .light))
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
                
                VStack(spacing: 30) {
                    tableProfileData()
                    
                    buttonMenu(label: "Orders")
                    
                    buttonMenu(label: "Pending reviews")
                    
                    buttonMenu(label: "Faq")
                }
                Spacer()
            }
            .padding(.horizontal, 30.0)
        }
    }
    
    // MARK: - ViewBuilder
    @ViewBuilder
    func tableProfileData() -> some View {
        VStack {
            HStack(alignment: .top) {
                if let image = viewModel.userImage {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 91, height: 100)
                        .clipped()
                        .cornerRadius(15)
                        .padding([.top, .leading])
                }
                ProfilleTextView(user: user)
                    .padding()
            }
            .background(Color.white)
            .cornerRadius(20)
            
        }
    }
    
    @ViewBuilder
    func buttonMenu(label: String) -> some View {
        Button {
            
        } label: {
            HStack {
                Text(label)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.black)
                
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.black)
            }
            .padding(.horizontal, 25)
        }
        .frame(height: 60)
        .background(Color.white)
        .cornerRadius(20)
    }
}
