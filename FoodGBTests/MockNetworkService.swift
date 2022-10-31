//
//  MockNetworkService.swift
//  FoodGBTests
//
//  Created by Алексей Ходаков on 31.10.2022.
//

import FirebaseAuth
@testable import FoodGB

class MockNetworkService: NetworkServiceProtocol {
    
    func getFoods(complietion: @escaping (Result<[Food], Error>) -> Void) {
        complietion(.success([Food(name: "dfv", description: "verv", foodImageUrl: "crev", price: 1)]))
    }
    
    func getUser(id: String, complietion: @escaping (Result<User, Error>) -> Void) {}
    
    func login(email: String, password: String, complietion: @escaping (Result<FirebaseAuth.User?, Error>) -> Void) {}
    
    func register(withEmail email: String, password: String, userName: String, complietion: @escaping (Result<FirebaseAuth.User?, Error>) -> Void) {}
    
    func updateUser(userName: String, phone: String, address: String, image: UIImage?, complition: @escaping (String) -> ())  {}

}
