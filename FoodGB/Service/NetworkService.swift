//
//  NetworkService.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 19.10.2022.
//

import FirebaseStorage
import FirebaseAuth
import UIKit

protocol NetworkServiceProtocol {
    func login(email: String, password: String, complietion: @escaping (Result<FirebaseAuth.User?, Error>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    
    func login(email: String, password: String, complietion: @escaping (Result<FirebaseAuth.User?, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                complietion(.failure(error))
            } else {
                guard let user = result?.user else { return }
                complietion(.success(user))
            }
        }
    }
    
    func uploaderImage(image: UIImage, completion: @escaping(String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        
        let fileName = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(fileName)")
        
        ref.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                print("DEBUG: Failed to upload image\(error.localizedDescription)")
                return
            }
            
            print("Successfully uplooader image...")
            
            ref.downloadURL { url, _ in
                guard let imageUrl = url?.absoluteString else { return }
                completion(imageUrl)
            }
        }
    }
}
