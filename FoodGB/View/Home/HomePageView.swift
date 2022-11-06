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
    @State var search = ""
    @State var currentMenu = "Foods"
    @StateObject var viewModel = HomeViewModel()
    
    var animation: Namespace.ID
    var menu = ["Foods", "Drinks", "Snacks", "Sushi", "Polls", "Pizza"]
    
    // MARK: - Views
    var body: some View {
        ZStack(alignment: .leading) {
            Color("Background")
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Text("Delicious food for you")
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(width: 180)
                    .padding(.horizontal, 30)
                    .padding(.top, 30)
                
                // Search
                ZStack {
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
                .padding(.horizontal, 30)
                .padding(.top, 30)
                
                // Tap bar
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(menu, id: \.self) { food in
                            foodCategory(food: food)
                        }
                    }
                    .padding(.top, 30)
                    .offset(x: 30)
                    .padding(.trailing, 70)
                }
                
                // Carousel
                FoodCarouselView(buttonDisabled: $buttonDisabled, viewModel: viewModel)
                Spacer()
            }
            .padding(.top, 30)
            .overlay {
                VStack {
                    Spacer()
                    HStack(spacing: 70) {
                        Image(systemName: "house.fill")
                            .scaleEffect(1.5)
                            .foregroundColor(Color("MainColor"))
                            .shadow(color: Color("MainColor")
                                .opacity(0.6), radius: 10)
                        
                        Image(systemName: "heart")
                            .scaleEffect(1.5)
                            .foregroundColor(.gray)
                        
                        Image(systemName: "person")
                            .scaleEffect(1.5)
                            .foregroundColor(.gray)
                        Image(systemName: "clock.arrow.circlepath")
                            .scaleEffect(1.5)
                            .foregroundColor(.gray)
                    }
                    .padding(.bottom)
                }
                .padding()
            }
        }
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
                }
        }
    }
}
