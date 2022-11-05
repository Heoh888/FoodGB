//
//  TapButtonMenu.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 27.10.2022.
//

import SwiftUI

struct TapButtonMenu: View {
    
    var image: String
    var title: String
    
    @Binding var selectedTab: String
    
    var animation: Namespace.ID
    
    var body: some View {
        Button(action: {
            withAnimation(.spring()) {
                selectedTab = title
            }
        }, label: {
            HStack(spacing: 10) {
                Image(systemName: image)
                    .font(.title2)
                    .frame(width: 30)
                
                Text(title)
                    .fontWeight(.semibold)
            }
            .foregroundColor(selectedTab == title ? Color("MainColor") : .white)
            .padding(.vertical, 12)
            .padding(.horizontal, 20)
            .frame(maxWidth: getRect().width - 170, alignment: .leading)
            .background(
                ZStack {
                    if selectedTab == title {
                        Color.white
                            .opacity(selectedTab == title ? 1 : 0)
                            .clipShape(CustomCorners(corners: [.topRight, .bottomRight], radius: 10))
                            .matchedGeometryEffect(id: "TAB", in: animation)
                    }
                }
            )
        })
    }
}
