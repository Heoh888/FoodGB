//
//  FoodCarouselView.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 28.10.2022.
//

import SwiftUI
import Kingfisher

struct FoodCarouselView: View {
    
    @Binding var buttonDisabled: Bool
    @StateObject var viewModel: HomeViewModel
    
    @State var showDetailsFood = false
    
    @State private var selectedData: Food?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 35) {
                ForEach(viewModel.foods) { food in
                    Button(action: {
                        selectedData = food
                    }, label: {
                        ZStack(alignment: .top) {
                            Rectangle()
                                .foregroundColor(.white)
                                .frame(width: 220, height: 270)
                                .cornerRadius(30)
                                .offset(y: 40)
                            
                            VStack {
                                KFImage(URL(string: food.foodImageUrl))
                                    .resizable()
                                    .frame(width: 164, height: 164)
                                    .shadow(color: .gray.opacity(0.2), radius: 10)
                                
                                Text(food.name)
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundColor(.black)
                                    .frame(height: 50)
                                    .padding()
                                
                                Text("\(food.price) $")
                                    .font(.system(size: 20, weight: .heavy))
                                    .foregroundColor(Color("MainColor"))
                                
                            }
                            
                        }
                        .shadow(color: .gray.opacity(0.5), radius: 30)
                        .frame(width: 220, height: 300)
                        .offset(y: -40)
                        .padding(.top, 35)
                        
                    })
                    .disabled(buttonDisabled)
                    .fullScreenCover(item: $selectedData) { item in
                        DetailsFoodView(food: item)
                    }
                }
            }
            .offset(x: 40)
            .frame(height: 450)
            .padding(.trailing, 80)
        }
    }
}

