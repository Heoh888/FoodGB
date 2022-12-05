//
//  OrderDetailsView.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 02.12.2022.
//

import SwiftUI
import Kingfisher

struct OrderDetailsView: View {
    
    var order: OrdersModel
    
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - NavigationBar
    var btnBack : some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.backward")
                .scaleEffect(0.8)
                .foregroundColor(.black)
        }
        .padding(.leading, 25)
    }
    
    // MARK: - Views
    var body: some View {
        ZStack(alignment: .leading) {
            Color("Background")
                .ignoresSafeArea()
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Name: ")
                                .font(.system(size: 17, weight: .bold))
                            Text("\(order.userName)")
                                .font(.system(size: 17, weight: .regular))
                        }
                        Divider()
                        HStack {
                            Text("Adrress: ")
                                .font(.system(size: 17, weight: .bold))
                            Text("\(order.address)")
                                .font(.system(size: 17, weight: .regular))
                        }
                        Divider()
                        HStack {
                            Text("Phone: ")
                                .font(.system(size: 17, weight: .bold))
                            Text("\(order.phone)")
                                .font(.system(size: 17, weight: .regular))
                        }
                        Divider()
                    }
                    .padding([.horizontal, .bottom], 30)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    ForEach(order.foods ?? []) { food in
                        foodCell(food: food)
                    }
                }
                .padding(.top, 30)
                Spacer()
                
                HStack {
                    Text("Total")
                        .font(.system(size: 20, weight: .semibold))
                    Spacer()
                    Text("\(order.total) $")
                        .font(.title)
                }
                .padding(.horizontal, 30)
                .padding(.bottom)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
    }
    
    @ViewBuilder
    func foodCell(food: Food) -> some View {
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
                        Text("\(food.price) $")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(Color("MainColor"))
                            .padding(.top, 2)
                        
                        Spacer()
                        
                        Text(food.count ?? "")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.black)
                    }
                }
                Spacer()
            }
            .padding(.horizontal)
        }
        .padding(.horizontal, 30)
    }
}
