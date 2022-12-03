//
//  MyFoodView.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 12.11.2022.
//

import SwiftUI

struct MyFoodsView: View {
    
    // MARK: - Properties
    @StateObject var viewModel: MyFoodsViewModel
    
    // MARK: - Views
    var body: some View {
        ZStack(alignment: .leading) {
            Color("Background_2")
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Text("My foods")
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(width: 180)
                    .padding(.top, 30)
                
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(viewModel.myFoods) { myFood in
                        MyFoodCell(viewModel: viewModel, myFood: myFood)
                    }
                    .padding(.top)
                }
                Spacer()
            }
            .padding(.top, 30)
        }
    }
}
