//
//  OrdersCell.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 15.11.2022.
//

import SwiftUI
import Kingfisher
import FirebaseAnalyticsSwift

struct OrdersCell: View {
    // MARK: - Properties
    @StateObject var viewModel: OrdersViewModel
    
    var food: Food
    
    // MARK: - Views
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .frame(height: 100)
                .foregroundColor(.white)
                .cornerRadius(20)
            HStack {
                KFImage(URL(string: food.foodImageUrl))
                    .resizable()
                    .frame(width: 70, height: 70)
                    .offset(x: -5)
                    .shadow(color: .gray.opacity(0.5), radius: 4)
                
                VStack(alignment: .leading) {
                    Text(food.name)
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.black)

                    HStack {
                        Text(food.price)
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(Color("MainColor"))
                            .padding(.top, 2)
                        
                        Spacer()
                        
                        buttonCart()
                    }
                }
                Spacer()
        
            }
            .padding(.horizontal)
        }
        .padding(.horizontal, 30)
    }
    
    @ViewBuilder
    func buttonCart() -> some View {
        ZStack {
            HStack{
                Button {
                    withAnimation(.spring()) {
                        if Int(food.count ?? "1")! <= 1 {
                            viewModel.deleteFoodCart(food: food)
                        } else {
                            viewModel.changeAmountFood(food: food, value: .less)
                        }
                    }
                } label: {
                    Text("-")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white)
                }
                
                Text(food.count ?? "1")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white)
                
                Button {
                    viewModel.changeAmountFood(food: food, value: .more)
                } label: {
                    Text("+")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white)
                }
            }
            .padding(3)
            .padding(.horizontal, 10)
            .background(Color("MainColor"))
            .cornerRadius(20)
        }
    }
}
