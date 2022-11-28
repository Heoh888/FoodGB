//
//  HomePageView.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 27.10.2022.
//

import SwiftUI

struct HomePageView: View {
    
    // MARK: - Properties
    @Binding var buttonDisabled: Bool
    @Binding var searchActivated: Bool
    @State var search = ""
    @State var currentMenu = "All"
    @StateObject var viewModel = HomeViewModel()
    @StateObject var myFoodsviewModel: MyFoodsViewModel
    @StateObject var ordersViewModel: OrdersViewModel
    
    var animation: Namespace.ID
    
    // MARK: - Views
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
                Text("Delicious food for you")
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(width: 180, height: 80)
                    .padding(.horizontal, 30)
                    .padding(.top, 30)
                
                // Search
                ZStack {
                    if viewModel.searchActivated {
                        searchbar()
                    } else {
                        searchbar()
                            .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                    }
                }
                .padding(.horizontal, 30)
                .padding(.top, 30)
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        viewModel.searchActivated = true
                    }
                    searchActivated = true
                }
                
                // Tap bar
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.typeFoods, id: \.self) { food in
                            foodCategory(food: food)
                        }
                    }
                    .padding(.top, 30)
                    .offset(x: 30)
                    .padding(.trailing, 70)
                }
                
                // Carousel
                FoodCarouselView(buttonDisabled: $buttonDisabled,
                                 viewModel: viewModel,
                                 myFoodsviewModel: myFoodsviewModel,
                                 ordersViewModel: ordersViewModel)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.top, 30)
        .background(Color("Background_2"))
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .overlay(
            ZStack {
                if viewModel.searchActivated {
                    SearchView(searchActivated: $searchActivated, animation: animation)
                        .environmentObject(viewModel)
                }
            }
        )
    }
    
    @ViewBuilder
    func searchbar() -> some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .padding(.leading, 30)
            TextField("Search", text: $search)
        }
        .background {
            Rectangle()
                .foregroundColor(.gray.opacity(0.08))
                .frame(height: 50)
                .cornerRadius(50)
        }
        .frame(width: getRect().width - 60)
    }
    
    // MARK: - ViewBuilder
    @ViewBuilder
    func foodCategory(food: String) -> some View {
        VStack {
            Text(food)
                .padding(.horizontal)
                .foregroundColor(currentMenu == food ? Color("MainColor") : .gray)
                .background(content: {
                    if currentMenu == food {
                        Rectangle()
                            .frame(height: 3)
                            .padding(.horizontal, 5)
                            .foregroundColor(Color("MainColor"))
                            .matchedGeometryEffect(id: "MENU", in: animation)
                            .offset(y: 20)
                    }
                })
                .frame(height: 50)
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        currentMenu = food
                    }
                    viewModel.filteredFoodsByType(type: currentMenu)
                }
        }
    }
}

