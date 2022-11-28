//
//  RadioBox.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 19.11.2022.
//

import SwiftUI

struct RadioBox: View {
    
    // MARK: - Properties
    var paymentBox = [ModelButton(title: "Card", image: "card"), ModelButton(title: "Bank account", image: "bank")]
    var deviliryBox = [ModelButton(title: "To the door"), ModelButton(title: "To the entrance")]
    
    @StateObject var viewModel: CheckoutOrdrersViewModel
    
    // MARK: - Views
    var body: some View {
        VStack{
            RadioButton(selected: viewModel.ditails["Payment method"]!,
                        viewModel: viewModel, title: "Payment method",
                        data: paymentBox)
            
            RadioButton(selected: viewModel.ditails["Deviliry"]!,
                        viewModel: viewModel, title: "Deviliry",
                        data: deviliryBox)
        }
    }
}
