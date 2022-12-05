//
//  CustomTextField.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 19.10.2022.
//

import SwiftUI

struct CustomTextField: View {
    
    // MARK: - Properties
    @Binding var text: String
    
    var label: String = ""
    var identifier: String
    var securityOption: Bool = false
    
    // MARK: - Views
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .opacity(0.5)
                .font(.system(size: 15, weight: .semibold))

            if securityOption {
                SecureField("", text: $text)
                    .accessibility(identifier: identifier)
            } else {
                TextField("", text: $text)
                    .accessibility(identifier: identifier)
            }
            Rectangle()
                .fill(Color.black)
                .frame(width: getRect().width - 80, height: 1)
        }
        .padding(.top, 30)
    }
}
