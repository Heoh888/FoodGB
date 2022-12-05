//
//  CheckoutOrdrersView.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 16.11.2022.
//

import SwiftUI

struct CheckoutOrdrersView: View {
    
    // MARK: - Properties
    @StateObject var viewModel = CheckoutOrdrersViewModel()
    @StateObject var ordersViewModel: OrdersViewModel
    @StateObject var ordersHistoryViewModel: OrderHistoryViewModel
    @Binding var selrctedTap: String
    
    var userName: String
    var address: String
    var phone: String
    var total: String
    
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
        ZStack(alignment: .leading) {
            Color("Background")
                .ignoresSafeArea()
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    addressDetails()
                    RadioBox(viewModel: viewModel)
                        .padding(.bottom)
                }
                Spacer()
                
                HStack {
                    Text("Total")
                        .font(.system(size: 20, weight: .semibold))
                    Spacer()
                    Text("\(total) $")
                        .font(.title)
                }
                .padding(.horizontal, 30)
                .padding(.bottom)
                
                Button {
                    viewModel.createOrder(foods: ordersViewModel.foodsCart,
                                          userName: userName,
                                          address: address,
                                          phone: phone,
                                          total: total)
                    ordersViewModel.foodsCart = []
                    ordersHistoryViewModel.getOrderHistory()
                    selrctedTap = "Home"
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Proceed to payment")
                        .font(.system(size: 17, weight: .semibold))
                        .fontWeight(.bold)
                        .frame(width: 314 , height: 70)
                        .background(Color("MainColor"))
                        .foregroundColor(Color.white)
                        .cornerRadius(30)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
    }
    
    @ViewBuilder
    func addressDetails() -> some View {
        VStack {
            HStack {
                Text("Personal details")
                    .font(.system(size: 18, weight: .semibold))
                Spacer()
            }
            .padding(.top)
            
            VStack {
                VStack( alignment: .leading) {
                    VStack(alignment: .leading) {
                        Text(userName)
                            .font(.system(size: 18, weight: .bold))
                            .opacity(0.7)
                        
                        Rectangle()
                            .fill(Color.black)
                            .opacity(0.5)
                            .frame(height: 1)
                    }
                    
                    VStack(alignment: .leading) {
                        Text(address)
                            .font(.system(size: 15, weight: .regular))
                            .opacity(0.7)
                        
                        Rectangle()
                            .fill(Color.black)
                            .opacity(0.5)
                            .frame(height: 1)
                    }
                    
                    VStack {
                        Text(phone)
                            .font(.system(size: 15, weight: .regular))
                            .opacity(0.7)
                    }
                }
                .padding(30)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(.white))
            .cornerRadius(20)
        }
        .padding(.horizontal, 30)
    }
}
