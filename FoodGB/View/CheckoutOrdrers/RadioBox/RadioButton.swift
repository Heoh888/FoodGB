//
//  RadioButton.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 23.11.2022.
//

import SwiftUI

struct RadioButton: View {
    
    // MARK: - Properties
    @State var selected: String
    @StateObject var viewModel: CheckoutOrdrersViewModel
    
    var title: String
    var data: [ModelButton]
    
    // MARK: - Views
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.system(size: 18, weight: .semibold))
                Spacer()
            }
            .padding(.top)
            
            VStack(alignment: .leading, spacing: 20) {
                ForEach(data) { button in
                    Button {
                        selected = button.title
                        viewModel.addDitails(key: title, value: button.title)
                    } label: {
                        HStack {
                            VStack(alignment: .center) {
                                ZStack(alignment: .center) {
                                    Circle()
                                        .strokeBorder(selected == button.title ? Color("MainColor") : Color.black.opacity(0.2), lineWidth: 1)
                                        .frame(width: 15, height: 15)
                                    
                                    if selected == button.title {
                                        Circle()
                                            .fill(Color("MainColor"))
                                            .frame(width: 7, height: 7)
                                    }
                                }
                            }
                            .frame(width: 20, height: 20)
                            
                            if let image = button.image {
                                Image(image)
                            }
                            
                            Text(button.title)
                            Spacer()
                        }
                        .foregroundColor(.black)
                    }
                }
            }
            .padding(30)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(.white))
            .cornerRadius(20)
        }
        .padding(.horizontal, 30)
    }
}

