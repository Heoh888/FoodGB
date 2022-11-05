//
//  NetworkServiceProtocol.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 02.11.2022.
//

import Foundation
import FirebaseAuth
import SwiftUI

protocol NetworkServiceProtocol {
    
    func getFoods(complietion: @escaping (Result<[Food], Error>) -> Void)

    /// - Parameters:
    ///   - id: id пользователя для `FireBase`.
    func getUser(id: String, complietion: @escaping (Result<User, Error>) -> Void)
    
    /// - Parameters:
    ///   - url: Url картинки пользователя в `FireBase`.
    /// - Returns: Возвращает `Image` аватар пользователя!
    func loadImage(url: String, complietion: @escaping (Image) -> ())
    
    func login(email: String, password: String, complietion: @escaping (Result<FirebaseAuth.User?, Error>) -> Void)
    
    func register(withEmail email: String, password: String, userName: String, complietion: @escaping (Result<FirebaseAuth.User?, Error>) -> Void)
    
    /// - Parameters:
    ///   - id: id пользователя для `FireBase`.
    /// - Returns: Возвращает url картинки пользователя полученного  от `uploaderImage()`
    func updateUser(userName: String, phone: String, address: String, image: UIImage?, id: String, complietion: @escaping (String, UIImage) -> Void)
    
    /// - Parameters:
    func updateData(data: [String: String], id: String)
    
    /// - Parameters:
    ///   - image: Аватар пользователя.
    /// - Returns: Возвращает url картинки пользователя полученного  от `FireBaase`
    func uploaderImage(image: UIImage, completion: @escaping(String) -> Void)
    
    func signout()
}
