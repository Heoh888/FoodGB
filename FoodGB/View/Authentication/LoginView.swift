//
//  LoginView.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 19.10.2022.
//

import SwiftUI

struct LoginView: View {
    
    // MARK: - Properties
    @Binding var email: String
    @Binding var password: String
    
    // MARK: - Views
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                CustomTextField(text: $email, label: "Email address", identifier: "Login Email address")
                CustomTextField(text: $password, label: "Password", identifier: "Login Password", securityOption: true)

                Button {
                    // TO:DO - сброс пароля
                } label: {
                    Text("Forgot passcode?")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(Color("MainColor"))
                        .cornerRadius(30)
                        .padding(.top, 30.0)
                }
            }
            .padding(.horizontal, 80)
        }
    }
}
