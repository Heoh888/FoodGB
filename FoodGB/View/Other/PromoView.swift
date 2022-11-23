//
//  PromoView.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 27.10.2022.
//

import SwiftUI

struct PromoView: View {
    
    // MARK: - Views
    var body: some View {
        ZStack(alignment: .leading) {
            Color("Background_2")
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                
                Text("Offer and promo")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 60)
                Spacer()
            }
            .padding(.horizontal, 30.0)
        }
    }
}

struct PromoView_Previews: PreviewProvider {
    static var previews: some View {
        PromoView()
    }
}
