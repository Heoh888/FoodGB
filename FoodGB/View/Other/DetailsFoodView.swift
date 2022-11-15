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
    @StateObject var myFoodsViewModel: MyFoodsViewModel
    @StateObject var ordersViewModel: OrdersViewModel
    @Environment(\.presentationMode) var presentationMode
    
    
    // MARK: - Views
    var body: some View {
        
        let isLiked = myFoodsViewModel.isLike(id: food.id!)
        
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
                    
                    Button {
                        if !isLiked {
                            myFoodsViewModel.addMyFood(food: food)
                        } else {
                            myFoodsViewModel.deleteMyFoods(id: food.id!)
                        }
                    } label: {
                        Image(systemName: isLiked ? "heart.fill" :  "heart")
                            .scaleEffect(1.3)
                            .foregroundColor(isLiked ? Color("MainColor") : .black)
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
                
                // TODO: Нормально развернуть опционал
                // Лучше если нет цены то и не отображать во все
                Text("\(food.price) $")
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundColor(Color("MainColor"))
                    .padding()
                
                VStack(alignment: .leading) {
                    Text("About food")
                        .font(.system(size: 17, weight: .bold))
                        .padding(.top)
                        .padding(.bottom, 3)
                    
                    Text(food.description ?? "")
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 50)
                Spacer()
                
                Button {
                    ordersViewModel.addFoodCart(food: food)
                    presentationMode.wrappedValue.dismiss()
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
