//
//  SearchView.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 25.11.2022.
//

import SwiftUI
import Kingfisher

struct SearchView: View {
    
    // MARK: - Properties
    @Binding var searchActivated: Bool
    @EnvironmentObject var viewModel: HomeViewModel
    @FocusState var startTF: Bool
    
    var animation: Namespace.ID
    
    // MARK: - Views
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 20) {
                Button {
                    searchActivated.toggle()
                    withAnimation {
                        viewModel.searchActivated = false
                    }
                    viewModel.searchText = ""
                } label: {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.black)
                }
                
                HStack(spacing: 15) {
                    TextField("Search", text: $viewModel.searchText)
                        .focused($startTF)
                        .textCase(.lowercase)
                        .disableAutocorrection(true)
                }
                .padding(.vertical)
                .padding(.horizontal)
                .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                .padding(.trailing, 20)
            }
            .padding(.horizontal, 50)
            
            if let foods = viewModel.searchedFoods {
                if foods.isEmpty {
                    VStack {
                        Spacer()
                        
                        searchEmpty()
                        Spacer()
                    }
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 0) {
                            
                            Text("Found \(foods.count) results")
                                .font(.system(size: 24, weight: .bold))
                                .padding(.vertical)
                            
                            StaggeradGrid(columns: 2, spacing: 20, list: foods) { food in
                                productCardView(food: food)
                                    .shadow(color: .gray.opacity(0.5), radius: 30)
                            }
                            .padding(.horizontal)
                        }
                        .padding()
                        .background(
                            Color(.white)
                                .cornerRadius(30)
                        )
                    }
                    .ignoresSafeArea()
                    .padding(.top)
                }
            } else {
                ProgressView()
                    .padding(.top, 30)
                    .opacity(viewModel.searchText == "" ? 0 : 1)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(
            Color("Background_2")
        )
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .onAppear {
            DispatchQueue.main.async {
                startTF = true
            }
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    
    @ViewBuilder
    func searchEmpty() -> some View {
        VStack(alignment: .center) {
            Image("search")
                .resizable()
                .resizable()
                .frame(width: 120, height: 115)
                .offset(x: -10)
            
            
            Text("Item not found")
                .multilineTextAlignment(.center)
                .font(.title)
                .padding()
            
            Text("Try searching the item with \na different keyword.")
        }
    }

    
    @ViewBuilder
    func productCardView(food: Food) -> some View {
        VStack(spacing: 10) {
            KFImage(URL(string: food.foodImageUrl))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .offset(y: -50)
                .padding(.bottom, -50)
            
            Text(food.name)
                .font(.system(size: 18, weight: .semibold))
                .padding(.top)
            
            Text(food.description ?? "")
                .font(.system(size: 14))
                .foregroundColor(.gray)
            
            Text("\(food.price) $")
                .font(.system(size: 16))
                .fontWeight(.bold)
                .foregroundColor(Color("MainColor"))
                .padding(.top, 5)
            
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 22)
        .background(
            Color.white
                .cornerRadius(25)
        )
        .padding(.top, 50)
    }
}

