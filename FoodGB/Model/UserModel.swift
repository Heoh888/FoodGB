//
//  Test.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 19.10.2022.
//

import FirebaseFirestoreSwift

struct User: Identifiable, Decodable {
    var userName: String
    let email: String
    var phone: String?
    var address: String?
    var profileImageUrl: String?
    @DocumentID var id: String?
    
    var isCurrentUser: Bool { return AuthViewModel.shared.userSession?.uid == id}
}
