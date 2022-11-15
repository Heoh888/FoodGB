//
//  OrdersView.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 27.10.2022.
//

import SwiftUI

struct OrdersView: View {
    
    @StateObject var ordersViewModel: OrdersViewModel
    @Binding var selrctedTap: String
    @Binding var currentTab: TabBar
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
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
        NavigationView {
            ZStack {
                Color("Background")
                    .ignoresSafeArea()
                VStack(alignment: .center) {
                    if ordersViewModel.foodsCart.isEmpty {
                        Spacer()
                        cartEmpty()
                    } else {
                        HStack {
                            Image("swipe")
                                .resizable()
                                .frame(width: 20, height: 20)
                                
                            
                            Text("swipe on an item to delete")
                                .font(.system(size: 13, weight: .regular))
                                .foregroundColor(.black)
                        }
                        .padding(.top, 30)
                        
                        basketFull()
                    }
                    
                    Spacer()
                    
                    Button {
                        selrctedTap = "Home"
                        currentTab = .homePage
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Start odering")
                            .font(.system(size: 17, weight: .semibold))
                            .fontWeight(.bold)
                            .frame(width: 314, height: 70)
                            .background(Color("MainColor"))
                            .foregroundColor(Color.white)
                            .cornerRadius(30)
                            .padding(.bottom, 20)
                    }
                }
            }
        }
        .navigationBarTitle(Text("OrdersView"))
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
    }
    
    @ViewBuilder
    func cartEmpty() -> some View {
        VStack(alignment: .center) {
            Image("Orders")
                .resizable()
                .resizable()
                .frame(width: 120, height: 115)
                .offset(x: -10)
            
            
            Text("No orders yet")
                .multilineTextAlignment(.center)
                .font(.title)
                .padding()
            
            Text("Hit the orange button down \nbelow to Create an order")
                .multilineTextAlignment(.center)
                .foregroundColor(.black.opacity(0.5))
        }
    }
    
    @ViewBuilder
    func basketFull() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(ordersViewModel.foodsCart) { food in
                OrdersCell(viewModel: ordersViewModel, food: food)
            }
            .padding(.top)
        }
    }
}
