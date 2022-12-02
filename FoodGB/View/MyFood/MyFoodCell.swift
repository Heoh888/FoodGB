//
//  MyFoodCell.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 12.11.2022.
//

import SwiftUI
import Kingfisher

struct MyFoodCell: View {
    
    // MARK: - Properties
    @StateObject var viewModel: MyFoodsViewModel
    
    var myFood: Food
    
    // MARK: - Views
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .frame(height: 100)
                .foregroundColor(.white)
                .cornerRadius(20)
            HStack {
                KFImage(URL(string: myFood.foodImageUrl))
                    .resizable()
                    .frame(width: 70, height: 70)
                    .offset(x: -5)
                    .shadow(color: .gray.opacity(0.5), radius: 4)
                
                Text(myFood.name)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.black)
                
                Spacer()
                
                Button {
                    viewModel.deleteMyFoods(id: myFood.id!)
                } label: {
                    Image(systemName: "heart.fill")
                        .scaleEffect(1.3)
                        .foregroundColor(Color("MainColor"))
                        .padding(.trailing, 30)
                }
            }
            .padding(.horizontal)
        }
        .padding(.horizontal, 30)
    }
}
