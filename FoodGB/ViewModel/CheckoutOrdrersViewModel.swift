//
//  CheckoutOrdrersViewModel.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 21.11.2022.
//

import Foundation

class CheckoutOrdrersViewModel: ObservableObject {
    
    // MARK: - Public Properties
    @Published var ditails = ["Payment method": "Card", "Deviliry": "To the door"]
    @Published var warning: String = ""
    
    // MARK: - Private properties
    private var  service: NetworkServiceProtocol!
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        return dateFormatter
    }()
    
    // MARK: - Initialisation
    init(service: NetworkServiceProtocol = NetworkService()) {
        self.service = service
    }
    
    // MARK: - Functions
    func addDitails(key: String, value: String) {
        ditails[key] = value
    }
    
    func createOrder(foods: [Food], userName: String, address: String, phone: String, total: String) {
        guard let uid = AuthViewModel.shared.currentUser?.id else { return }
        
        let data = ["user_name": userName,
                    "address": address,
                    "phone": phone,
                    "total": total,
                    "payment_method": ditails["Payment method"] ?? "",
                    "deviliry": ditails["Deviliry"] ?? "",
                    "data": dateFormatter.string(from: Date())]
        
        service.createOrder(foods: foods, uid: uid, data: data)
        service.deleteFoodsCart(foods: foods, uid: uid)
    }
}
