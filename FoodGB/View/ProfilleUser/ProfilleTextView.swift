//
//  CastomText.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 19.10.2022.
//

import SwiftUI

struct ProfilleTextView: View {
    
    // MARK: - Properties
    var user: User
    
    // MARK: - Views
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text(user.userName)
                    .font(.system(size: CGFloat(18)))
                    .bold()
                    .padding(.top, 3.0)
            }
            
            VStack(alignment: .leading) {
                Text(user.email)
                    .font(.system(size: CGFloat(15)))
                    .opacity(0.5)
                    .padding(.top, 2.0)
            }
            
            if user.phone != "" && user.phone != nil {
                VStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.black)
                        .opacity(0.5)
                        .frame(height: 1)
                    
                    Text(user.phone ?? "")
                        .font(.system(size: CGFloat(15)))
                        .opacity(0.5)
                        .padding(.top, 2.0)
                }
            }
            
            if user.address != "" && user.address != nil {
                VStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.black)
                        .opacity(0.5)
                        .frame(height: 1)
                    
                    Text(user.address ?? "")
                        .font(.system(size: CGFloat(15)))
                        .opacity(0.5)
                        .padding(.top, 2.0)
                }
            }
        }
    }
}
