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
            Capsule()
                .frame(height: 100)
                .foregroundColor(.white)
            HStack {
                KFImage(URL(string: myFood.foodImageUrl))
                    .resizable()
                    .frame(width: 110, height: 110)
                    .offset(x: -5)
                
                Text(myFood.name)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(width: 130)
                Spacer()
                
                Button {
                    viewModel.deleteMyFoods(id: myFood.id!)
                } label: {
                    Image(systemName: "heart.fill")
                        .scaleEffect(1.3)
                        .foregroundColor(Color("MainColor"))
                        .padding(.trailing, 50)
                }
            }
        }
    }
}
