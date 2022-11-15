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

    // MARK: - User functions
    //  Функция запрашивает у баззы данных информацию о пользователе
    /// - Parameters:
    ///   - id: id пользователя для `FireBase`.
    /// - Returns: Возвращает  данные `User` полученные  от `FireBaase`
    func getUser(id: String, complietion: @escaping (Result<User, Error>) -> Void)

    //  Функция формирует данные пользователя
    /// - Parameters:
    ///   - id: id пользователя для `FireBase`.
    /// - Returns: Возвращает url картинки пользователя полученного  от `uploaderImage()`
    func updateUser(userName: String, phone: String, address: String, image: UIImage?, id: String, complietion: @escaping (String, UIImage) -> Void)
    
    // MARK: - Data functions
    //  Функция обновляет данные пользователя в `FireBase`.
    /// - Parameters:
    ///   - data: Информация о пользователе полученная из `User`.
    ///   - id: пользователя для `FireBase`.
    func updateData(data: [String: String], id: String)
    
    // MARK: - Image functions
    // Функция загружает изображегние пользователя по ссылки из данных хронящихся в `User` в поле `profileImageUrl`
    /// - Parameters:
    ///   - url: Url картинки пользователя в `FireBase`.
    /// - Returns: Возвращает `Image` аватар пользователя!
    func loadImage(url: String, complietion: @escaping (Image) -> ())
    
    //  Функция загружает изображегние в базу данных `FireBaase` и возращает `url`
    /// - Parameters:
    ///   - image: Аватар пользователя.
    /// - Returns: Возвращает url картинки пользователя полученного  от `FireBaase`
    func uploaderImage(image: UIImage, completion: @escaping(String) -> Void)
    
    
    // MARK: - Food functions
    //  Функция меняет количество конкретного товара в корзине
    /// - Parameters:
    ///   - uid: индификатор пользователя.
    ///   - id: индификатор продукта.
    ///   - count: количество продукта.
    func changeAmountFood(uid: String, id: String, count: String)
    
    //  Функция добовляеет `Food` в карзину
    /// - Parameters:
    ///   - food: Информация о пользователе полученная из `User`.
    ///   - uid: индификатор пользователя.
    ///   - id: индификатор продукта.
    func addFoodCart(food: Food, uid: String, id: String)
    
    //  Функция получает массив [Food] из каталога foodsCart
    /// - Parameters:
    ///   - id: индификатор пользователя.
    /// - Returns: Возвращает массив `[Food]` полученного  от `FireBaase`
    func getFoodCart(id: String, complietion: @escaping (Result<[Food], Error>) -> Void)
    
    //  Функция удаляет продукт из корзины
    /// - Parameters:
    ///   - uid: индификатор пользователя.
    ///   - id: индификатор продукта.
    func deleteFoodCart(uid: String, id: String)
    
    //  Функция запрашивает у баззы данных каталог с товарами
    /// - Returns: Возвращает  массив `Food` полученные  от `FireBaase`
    func getFoods(complietion: @escaping (Result<[Food], Error>) -> Void)
    
    //  Функция добовляеет `Food` в избранное
    /// - Parameters:
    ///   - food: Информация о пользователе полученная из `User`.
    ///   - uid: индификатор пользователя.
    ///   - id: индификатор продукта.
    func addMyFood(food: Food, uid: String, id: String)
    
    //  Функция получает массив [Food] из каталога myFoods
    /// - Parameters:
    ///   - id: индификатор пользователя.
    /// - Returns: Возвращает массив `[Food]` полученного  от `FireBaase`
    func getMyFood(id: String, complietion: @escaping (Result<[Food], Error>) -> Void)
    
    //  Функция удаляет продукт из избранного
    /// - Parameters:
    ///   - uid: индификатор пользователя.
    ///   - id: индификатор продукта.
    func deleteMyFoods(uid: String, id: String)
    
    // MARK: - Authentication functions
    func login(email: String, password: String, complietion: @escaping (Result<FirebaseAuth.User?, Error>) -> Void)
    
    func register(withEmail email: String, password: String, userName: String, complietion: @escaping (Result<FirebaseAuth.User?, Error>) -> Void)
    
    func signout()
}
