//
//  OrderModel.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 01.12.2022.
//

import FirebaseFirestoreSwift

struct OrdersModel: Hashable, Identifiable, Decodable {
    let userName: String
    let address: String
    let phone: String
    let total: String
    let data: String
    let deviliry: String
    let paymentMethod: String
    var foods: [Food]?
    @DocumentID var id: String?
    
    enum CodingKeys: String, CodingKey {
        case id, address, phone, total, data, deviliry, foods
        case userName = "user_name"
        case paymentMethod = "payment_method"
    }
}

