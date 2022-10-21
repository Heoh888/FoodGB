//
//  KeyboardAdaptive.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 21.10.2022.
//

import Combine
import SwiftUI

struct KeyboardAdaptive: ViewModifier {
    
    // MARK: - Properties
    @State private var keyboardHeight: CGFloat = 0

    // MARK: - Functions
    func body(content: Content) -> some View {
        content
            .padding(.bottom, keyboardHeight)
            .onReceive(Publishers.keyboardHeight) { self.keyboardHeight = $0 }
    }
}
