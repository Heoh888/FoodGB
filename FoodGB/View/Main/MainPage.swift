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
    case profilePage = "person"
    case inPprocessing = "timer.circle"
}

struct MainPage: View {
    
    // MARK: - Properties
    @State var currentTab: TabBar = .homePage
    @Binding var buttonDisabled: Bool
    @Binding var user: User
    @Namespace var animation
    @StateObject var profileViewModel = ProfileViewModel()
    @StateObject var myFoodsViewModel = MyFoodsViewModel()
    
    // MARK: - Views
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $currentTab) {
                HomePageView(buttonDisabled: $buttonDisabled, myFoodsviewModel: myFoodsViewModel, animation: animation)
                    .tag(TabBar.homePage)
                
                MyFoodsView(viewModel: myFoodsViewModel)
                    .tag(TabBar.likedPage)
                
                ProfilleView(user: $user, viewModel: profileViewModel)
                    .tag(TabBar.profilePage)
                
                Text("Cart")
                    .tag(TabBar.inPprocessing)
            }
            
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
        }
        .background(Color.gray.opacity(0.1).ignoresSafeArea())
    }
}
