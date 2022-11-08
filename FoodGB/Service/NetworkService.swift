//
//  NetworkService.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 19.10.2022.
//

import FirebaseStorage
import FirebaseAuth
import SwiftUI

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
    
    func loadImage(url: String, complietion: @escaping (Image) -> ()) {
        guard let url = URL(string: url) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let image = UIImage(data: data) else { return }
            complietion(Image(uiImage: image))
        }
        task.resume()
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
    
    func updateUser(userName: String, phone: String, address: String, image: UIImage?, id: String, complietion: @escaping (String, UIImage) -> Void)  {
        let data = ["userName": userName,
                    "phone": phone,
                    "address": address,
                    "profileImageUrl": ""]
        
        if let img = image {
            
            /// Операция загрузки `img` в Firebase.Storage.
            /// Также операция возвращает `imageUrl` только что загруженного изображения
            let queue = OperationQueue()
            let getImageUrl = ImageUploaderOperation(image: img)
            queue.addOperation(getImageUrl)
            
            /// Операция  обновляет информацию о пользователе
            let uploadeDate = UplouderDataOperation(id: id, data: data)
            uploadeDate.addDependency(getImageUrl)
            uploadeDate.completionBlock = {
                OperationQueue.main.addOperation {
                    complietion(uploadeDate.urlImage!, img)
                }
            }
            OperationQueue.main.addOperation(uploadeDate)
            
            /// TO:DO - Добавить операцию для удаление предыдущий картинки пользователя
        } else {
            let uploadeDate = UplouderDataOperation(id: id, data: data)
            OperationQueue.main.addOperation(uploadeDate)
        }
    }
    
    func updateData(data: [String: String], id: String) {
        COLLECTION_USERS.document(id).updateData(data) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    func uploaderImage(image: UIImage, completion: @escaping(String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.1) else { return }
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
    
    func signout() { try? Auth.auth().signOut() }
}
