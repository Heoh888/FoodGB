//
//  MainPage.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 12.11.2022.
//

import SwiftUI

enum TabBar: String, CaseIterable {
    case homePage = "house"
    case likedPage = "heart"
    case tagPage = "tag"
    case inPprocessing = "timer.circle"
}

struct MainPage: View {
    
    // MARK: - Properties
    @Binding var currentTab: TabBar
    @Binding var buttonDisabled: Bool
    @Binding var searchActivated: Bool
    @Binding var user: User
    @Namespace var animation
    @StateObject var myFoodsViewModel = MyFoodsViewModel()
    @StateObject var ordersViewModel: OrdersViewModel
    
    // MARK: - Views
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $currentTab) {
                HomePageView(buttonDisabled: $buttonDisabled,
                             searchActivated: $searchActivated,
                             myFoodsviewModel: myFoodsViewModel,
                             ordersViewModel: ordersViewModel,
                             animation: animation)
                    .tag(TabBar.homePage)
                
                MyFoodsView(viewModel: myFoodsViewModel)
                    .tag(TabBar.likedPage)
                
                PromoView()
                    .tag(TabBar.tagPage)
                
                HistoryView()
                    .tag(TabBar.inPprocessing)
            }
            
            if !searchActivated {
                HStack {
                    ForEach(TabBar.allCases, id: \.self) { tab in
                        Button {
                            currentTab = tab
                        } label: {
                            Image(systemName: currentTab == tab ? tab.rawValue + ".fill" : tab.rawValue )
                                .scaleEffect(1.5)
                                .foregroundColor(currentTab == tab ? Color("MainColor") : Color.black.opacity(0.3))
                                .frame(maxWidth: .infinity)
                                .shadow(color: Color("MainColor")
                                    .opacity(0.6), radius: currentTab == tab ? 10 : 0)
                        }
                    }
                }
                .padding([.horizontal, .top])
                .padding(.bottom, 10)
                .background(Color("Background_2").ignoresSafeArea())
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}
