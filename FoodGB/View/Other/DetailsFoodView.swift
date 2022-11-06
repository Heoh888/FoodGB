//
//  DetailsFoodView.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 26.10.2022.
//

import SwiftUI
import Kingfisher

struct DetailsFoodView: View {
    
    // MARK: - Properties
    @State var like = false
    var food: Food
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - Views
    var body: some View {
        ZStack(alignment: .leading) {
            Color("Background")
                .ignoresSafeArea()
            VStack {
                HStack {
                    Image(systemName: "chevron.backward")
                        .scaleEffect(1.3)
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                    Spacer()
                    
                    Image(systemName: like ? "heart.fill" :  "heart")
                        .scaleEffect(1.3)
                        .foregroundColor(like ? Color("MainColor") : .black)
                        .onTapGesture {
                            withAnimation {
                                like.toggle()
                            }
                        }
                }
                .padding(.top, 25)
                .padding(.horizontal, 50)
                
                KFImage(URL(string: food.foodImageUrl))
                    .resizable()
                    .frame(width: 241, height: 241)
                    .shadow(color: .gray.opacity(0.5), radius: 20, y: 20)
                    .padding(.top)
                
                
                Text(food.name)
                    .font(.system(size: 28, weight: .semibold))
                    .multilineTextAlignment(.center)
                    .frame(height: 70)
                    .padding()
                    .padding(.top)
                
                Text("\(food.price) $")
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundColor(Color("MainColor"))
                    .padding()
                
                VStack(alignment: .leading) {
                    Text("About food")
                        .font(.system(size: 17, weight: .bold))
                        .padding(.top)
                        .padding(.bottom, 3)
                    
                    Text(food.description)
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 50)
                Spacer()
                
                Button {
                    print(food)

                } label: {
                    Text("Add to cart")
                        .font(.system(size: 17, weight: .semibold))
                        .fontWeight(.bold)
                        .frame(width: 314, height: 70)
                        .background(Color("MainColor"))
                        .foregroundColor(Color.white)
                        .cornerRadius(30)
                        .padding(.top)
                        .padding(.bottom, 30.0)
                }
            }
        }
    }
}
