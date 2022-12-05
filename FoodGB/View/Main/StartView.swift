//
//  StartView.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 19.10.2022.
//

import SwiftUI

struct StartView: View {
    
    // MARK: - Properties
    @Binding var starteed: Bool
    
    // MARK: - Views
    var body: some View {
        ZStack {
            Color("MainColor")
                .ignoresSafeArea()
        
            VStack(alignment: .leading) {
                ZStack {
                    Circle()
                        .fill(Color.white)
                    
                    Image("logo")
                        .resizable()
                        .frame(width: 45, height: 45)
                }
                .frame(width: 75, height: 75)
                .padding(.leading, 49.0)
                
                Image("Food")
                    .padding(.top, 30)
                    .padding(.leading, 49.0)
                
                ZStack(alignment: .bottom) {
                    Image("ToyFaces_Tansparent_BG_29")
                        .frame(width: UIScreen.main.bounds.width, height: 298.54, alignment: .trailing)
                        .offset(y: -30)
                    
                    Image("ToyFaces_Tansparent_BG_49")

                        .frame(width: UIScreen.main.bounds.width, height: 434.36, alignment: .leading)
                        .imageScale(.small)

                    ZStack {
                        Image("Rectangle 3")
                            .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                            .offset(y: 100)
                        
                        Image("Rectangle 5")
                            .frame(width: UIScreen.main.bounds.width, alignment: .trailing)
                            .offset(y: 100)
                    }
                }
                
                ZStack(alignment: .center) {
                    Button {
                        withAnimation {
                            starteed.toggle()
                        }
                    } label: {
                        Text("Get starteed")
                            .font(.system(size: 17, weight: .semibold))
                            .frame(width: 314, height: 70)
                            .foregroundColor(Color("MainColor"))
                            .background(Color.white)
                            .cornerRadius(30)
                            .accessibilityIdentifier("start button")
                    }
                }
                .frame(width: UIScreen.main.bounds.width)
            }
        }
    }
}
