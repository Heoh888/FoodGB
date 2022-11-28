//
//  HistoryView.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 23.11.2022.
//

import SwiftUI

struct HistoryView: View {
    var body: some View {
        ZStack(alignment: .leading) {
            Color("Background_2")
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                
                Text("History")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 60)
                Spacer()
            }
            .padding(.horizontal, 30.0)
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
