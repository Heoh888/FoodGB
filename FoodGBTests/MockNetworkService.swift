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
    func getOrderDetails(uid: String, complietion: @escaping ([OrdersModel]) -> Void) {
        
    }
    
    func getOrders(uid: String, complietion:  @escaping ([OrdersModel]) -> Void) {
        complietion([OrdersModel(userName: "Test",
                                 address: "Test",
                                 phone: "Test",
                                 total: "Test",
                                 data: "Test",
                                 deviliry: "Test",
                                 paymentMethod: "Test")])
    }
    
    func getFoodsOrder(uid: String, id: String, complietion: @escaping ([Food]) -> Void) {
        complietion([Food(name: "TestFood",
                          description: "TestFood",
                          foodImageUrl: "TestFood",
                          price: "1",
                          count: "1",
                          id: "test")])
    }
    
    func createOrder(foods: [Food], uid: String, data: [String : String]) {}
    
    func changeAmountFood(uid: String, id: String, count: String) {}
    
    func addFoodCart(food: Food, uid: String, id: String) {}
    
    func deleteFoodsCart(foods: [Food], uid: String) {}
    
    func getFoodCart(id: String, complietion: @escaping (Result<[Food], Error>) -> Void) {
        complietion(.success([Food(name: "TestFood",
                                   description: "TestFood",
                                   foodImageUrl: "TestFood",
                                   price: "1",
                                   count: "1",
                                   id: "test")]))
    }
    
    func deleteFoodCart(uid: String, id: String) {}
    
    func updateUser(userName: String, phone: String, address: String, image: UIImage?, id: String, complietion: @escaping (String, UIImage) -> Void) {
        guard let image = UIImage(named: "card") else { return }
        complietion("http://test.ru", image)
    }
    
    func addMyFood(food: Food, uid: String, id: String) {}
    
    func getMyFood(id: String, complietion: @escaping (Result<[Food], Error>) -> Void) {
        complietion(.success([Food(name: "TestFood",
                                   description: "TestFood",
                                   foodImageUrl: "TestFood",
                                   price: "10",
                                   id: "test")]))
    }
    
    func deleteMyFoods(uid: String, id: String) {
    }
    
    
    func loadImage(url: String, complietion: @escaping (Image) -> ()) {
        complietion(Image("userImage"))
    }
    
    func getFoods(complietion: @escaping (Result<[Food], Error>) -> Void) {
        complietion(.success([Food(name: "TestFood",
                                   description: "TestFood",
                                   foodImageUrl: "TestFood",
                                   price: "1",
                                   type: "Food")]))
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
