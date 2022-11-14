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
        NavigationView {
            Text("PromoView")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(.primary)
                .navigationTitle("PromoView")
        }
    }
}

struct PromoView_Previews: PreviewProvider {
    static var previews: some View {
        PromoView()
    }
}
