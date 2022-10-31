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
    func getFoods(complietion: @escaping (Result<[Food], Error>) -> Void)
    func getUser(id: String, complietion: @escaping (Result<User, Error>) -> Void)
    func login(email: String, password: String, complietion: @escaping (Result<FirebaseAuth.User?, Error>) -> Void)
    func register(withEmail email: String, password: String, userName: String, complietion: @escaping (Result<FirebaseAuth.User?, Error>) -> Void)
    func updateUser(userName: String, phone: String, address: String, image: UIImage?, complition: @escaping (String) -> ())
}

final class NetworkService: NetworkServiceProtocol {
    
    func getFoods(complietion: @escaping (Result<[Food], Error>) -> Void) {
        COLLECTION_FOODS.getDocuments { snapshot, error in
            if let error = error {
                complietion(.failure(error))
            } else {
                var foods = [Food]()
                for document in snapshot!.documents {
                    guard let food = try? document.data(as: Food.self) else { return }
                    foods.append(food)
                }
                complietion(.success(foods))
            }
        }
    }
    
    func getUser(id: String, complietion: @escaping (Result<User, Error>) -> Void) {
        COLLECTION_USERS.document(id).getDocument { snapshot, error in
            if let error = error {
                complietion(.failure(error))
            } else {
                guard let user = try? snapshot?.data(as: User.self) else { return }
                complietion(.success(user))
            }
        }
    }
    
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
    
    func register(withEmail email: String, password: String, userName: String, complietion: @escaping (Result<FirebaseAuth.User?, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                complietion(.failure(error))
            } else {
                guard let user = result?.user else { return }
                
                let data = ["userName": userName,
                            "email": email,
                            "uid": user.uid]
                
                COLLECTION_USERS.document(user.uid).setData(data) { _ in
                    print("Successfully uplooader user data...")
                    complietion(.success(user))
                }
            }
        }
    }
    
    // TO:DO - Преработать логику
    func updateUser(userName: String, phone: String, address: String, image: UIImage?, complition: @escaping (String) -> ())  {
        guard let uid = AuthViewModel.shared.currentUser!.id else { return }
        
        if let img = image {
            uploaderImage(image: img) { imageUrl in
                
                let data = ["userName": userName,
                            "phone": phone,
                            "address": address,
                            "profileImageUrl": imageUrl]
                
                
                COLLECTION_USERS.document(uid).updateData(data) { err in
                    if let err = err {
                        complition(err.localizedDescription)
                        print("Error updating document: \(err)")
                    } else {
                        AuthViewModel.shared.getUser()
                        print("Document successfully updated")
                        complition(imageUrl)
                    }
                }
            }
        } else {
            let data = ["userName": userName,
                        "phone": phone,
                        "address": address]
            
            COLLECTION_USERS.document(uid).updateData(data) { err in
                if let err = err {
                    complition(err.localizedDescription)
                    print("Error updating document: \(err)")
                } else {
                    AuthViewModel.shared.getUser()
                    print("Document successfully updated")
                }
            }
        }
    }
    
    private func uploaderImage(image: UIImage, completion: @escaping(String) -> Void) {
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
