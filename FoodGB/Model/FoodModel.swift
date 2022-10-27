//
//  FoodModel.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 26.10.2022.
//

import FirebaseFirestoreSwift

struct Food: Decodable {
    var name: String
    let description: String?
    var foodImageUrl: String?
    var price: Int
}
