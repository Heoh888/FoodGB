//
//  RegistrationView.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 19.10.2022.
//

import SwiftUI

struct RegistrationView: View {
    
    // MARK: - Properties
    @Binding var userName: String
    @Binding var email: String
    @Binding var password: String
    
    // MARK: - Views
    var body: some View {
        ZStack{
            VStack(alignment: .leading) {
                CustomTextField(text: $userName, label: "Name")
                CustomTextField(text: $email, label: "Email address")
                CustomTextField(text: $password, label: "Password", securityOption: true)
            }
            .padding(.horizontal, 80)
        }
    }
}
