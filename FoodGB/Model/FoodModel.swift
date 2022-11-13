//
//  FoodModel.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 26.10.2022.
//

import FirebaseFirestoreSwift

struct Food: Hashable, Identifiable, Decodable {
    var name: String
    let description: String
    var foodImageUrl: String
    var price: Int?
    @DocumentID var id: String?
}
