//
//  HomePageView.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 27.10.2022.
//

import SwiftUI

struct HomePageView: View {
    
    @State var search = ""
    @State var currentMenu = "Foods"
    
    var animation: Namespace.ID
    
    var menu = ["Foods", "Drinks", "Snacks", "Sushi", "Polls", "Pizza"]
    
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
                        ForEach(menu, id: \.self) { menu in
                            VStack {
                                Text(menu)
                                    .padding(.horizontal)
                                    .foregroundColor(currentMenu == menu ? Color("MainColor") : .gray)
                                    .background(content: {
                                        if currentMenu == menu {
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
                                            currentMenu = menu
                                        }
                                    }
                            }
                        }
                    }
                    .padding(.top, 30)
                    .offset(x: 30)
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top, spacing: 35) {
                        ForEach(0..<4) { _ in
                            ZStack(alignment: .top) {
                                Rectangle()
                                    .foregroundColor(.white)
                                    .frame(width: 220, height: 270)
                                    .cornerRadius(30)
                                    .offset(y: 40)
                                
                                VStack {
                                    Image("food1")
                                        .resizable()
                                        .frame(width: 164, height: 164)
                                        .shadow(color: .gray.opacity(0.2), radius: 10)
                                    
                                    Text("Veggie tomato mix")
                                        .font(.system(size: 20, weight: .semibold))
                                        .padding()
                                        .padding(.top)
                                    
                                    Text("1.50 $")
                                        .font(.system(size: 20, weight: .heavy))
                                        .foregroundColor(Color("MainColor"))
                                    
                                }
                                
                            }
                            .shadow(color: .gray.opacity(0.5), radius: 30)
                            .frame(width: 220, height: 300)
                            .offset(y: -40)
                            .padding(.top, 35)
                        }
                    }
                    .offset(x: 40)
                    .frame(height: 450)
                }
                
                
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
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
