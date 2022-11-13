//
//  MockNetworkService.swift
//  FoodGBTests
//
//  Created by Алексей Ходаков on 31.10.2022.
//

import FirebaseAuth
import SwiftUI
@testable import FoodGB

class MockNetworkService: NetworkServiceProtocol {
    func updateUser(userName: String, phone: String, address: String, image: UIImage?, id: String, complietion: @escaping (String, UIImage) -> Void) {
    }
    
    func addMyFood(food: Food, uid: String, id: String) {
    }
    
    func getMyFood(id: String, complietion: @escaping (Result<[Food], Error>) -> Void) {
        complietion(.success([Food(name: "TestFood",
                                   description: "TestFood",
                                   foodImageUrl: "TestFood",
                                   price: 1)]))
    }
    
    func deleteMyFoods(uid: String, id: String) {
    }
    
    
    func loadImage(url: String, complietion: @escaping (Image) -> ()) {
        complietion(Image("userImage"))
    }
    
    func updateUser(userName: String,
                    phone: String,
                    address: String,
                    image: UIImage?,
                    id: String,
                    complietion: @escaping (String) -> Void) {
        complietion("http://test.com")
    }
    

    func getFoods(complietion: @escaping (Result<[Food], Error>) -> Void) {
        complietion(.success([Food(name: "TestFood",
                                   description: "TestFood",
                                   foodImageUrl: "TestFood",
                                   price: 1)]))
    }
    
    func getUser(id: String,
                 complietion: @escaping (Result<User, Error>) -> Void) {
        complietion(.success(User(userName: "TestName",
                                  email: "test@gmail.com")))
    }
    
    func login(email: String,
               password: String,
               complietion: @escaping (Result<FirebaseAuth.User?, Error>) -> Void) {}
    
    func register(withEmail email: String,
                  password: String,
                  userName: String,
                  complietion: @escaping (Result<FirebaseAuth.User?, Error>) -> Void) {}
    
    func signout() {}
   
    func updateUser(userName: String,
                    phone: String,
                    address: String,
                    image: UIImage?,
                    complition: @escaping (String) -> ()) {}
        
    func updateData(data: [String: String], id: String) {}
    
    func uploaderImage(image: UIImage,
                       completion: @escaping(String) -> Void) {}
}
