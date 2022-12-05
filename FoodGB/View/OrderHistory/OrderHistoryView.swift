//
//  HistoryView.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 23.11.2022.
//

import SwiftUI
import Kingfisher

struct OrderHistoryView: View {
    
    // MARK: - Properties
    @StateObject var viewModel: OrderHistoryViewModel
    
    // MARK: - Views
    var body: some View {
        ZStack(alignment: .leading) {
            Color("Background_2")
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                
                Text("History")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 60)
                    
                Spacer()
                if viewModel.orders.isEmpty {
                    historyEmpty()
                        .frame(maxWidth: .infinity, alignment: .center)
                    Spacer()
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(viewModel.orders) { order in
                            NavigationLink {
                                OrderDetailsView(order: order)
                                .navigationBarTitle(Text("Ditails"))
                            } label: {
                                OrderHistoryCell(order: order)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 30.0)
        }
    }
    
    @ViewBuilder
    func historyEmpty() -> some View {
        VStack(alignment: .center) {
            Image("history_2")
                .resizable()
                .resizable()
                .frame(width: 120, height: 115)
                .offset(x: -10)
            
            
            Text("No history yet")
                .multilineTextAlignment(.center)
                .font(.title)
                .padding()
            
            Text("Hit the orange button down \nbelow to Create an order")
                .multilineTextAlignment(.center)
                .foregroundColor(.black.opacity(0.5))
        }
    }
    
    // MARK: - OrderHistoryCell
    @ViewBuilder
    func OrderHistoryCell(order: OrdersModel) -> some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .frame(height: 100)
                .foregroundColor(.white)
                .cornerRadius(20)
            HStack(spacing: 100) {
                ZStack {
                    ForEach(Array(order.foods!.enumerated()), id: \.offset) { index, food in
                        KFImage(URL(string: food.foodImageUrl))
                            .resizable()
                            .frame(width: 70, height: 70)
                            .offset(x: CGFloat(index) * 20)
                    }
                }
                HStack {
                    Spacer()
                    VStack {
                        Spacer()
                        HStack(alignment: .center) {
                            Text("Total:")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                            
                            Text("\(order.total) $")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(Color("MainColor"))
                        }
                        VStack(alignment: .center) {
                            Text("Completed")
                                .font(.system(size: 13, weight: .semibold))
                                .fontWeight(.bold)
                                .frame(width: 100, height: 30)
                                .background(Color("MainColor").opacity(0.5))
                                .foregroundColor(Color.white)
                                .cornerRadius(30)
                        }
                    }
                    .padding(.bottom)
                    .padding(.trailing)
                }
            }
            .padding(.leading)
        }
        .padding(.vertical, 1)
    }
}
