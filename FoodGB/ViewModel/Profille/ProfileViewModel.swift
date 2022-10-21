//
//  ProfileViewModel.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 19.10.2022.
//

import Firebase
import SwiftUI

class ProfileViewModel: ObservableObject {
    
    // MARK: - Properties
    var service = NetworkService()
    
    // MARK: - Functions
    func updateUser(userName: String, phone: String, address: String, image: UIImage, complition: @escaping (String) -> ())  {
        
        guard let uid = AuthViewModel.shared.currentUser!.id else { return }
        
        NetworkService.uploaderImage(image: image) { imageUrl in
            let data = ["userName": userName,
                        "phone": phone,
                        "address": address,
                        "profileImageUrl": imageUrl]
            
            COLLECTION_USERS.document(uid).updateData(data) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    AuthViewModel.shared.fetchUser()
                    print("Document successfully updated")
                    return complition(imageUrl)
                }
            }
        }
    }
    
    func updateUser(userName: String, phone: String, address: String)  {
        
        guard let uid = AuthViewModel.shared.currentUser!.id else { return }
        
        let data = ["userName": userName,
                    "phone": phone,
                    "address": address]
        
        COLLECTION_USERS.document(uid).updateData(data) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                AuthViewModel.shared.fetchUser()
                print("Document successfully updated")
            }
        }
    }
}
