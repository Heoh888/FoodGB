//
//  DetailsFoodViewModel.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 15.11.2022.
//

import Foundation

enum MoreLess {
    case less
    case more
}

class OrdersViewModel: ObservableObject {
    // MARK: - Properties
    @Published var foodsCart: [Food] = []
    @Published var totalPrice: String = ""
    @Published var currentUser: User?
    @Published var error: Error?
    
    var uid: String = ""
    
    // MARK: - Private properties
    private var  service: NetworkServiceProtocol!
    
    // MARK: - Initialisation
    init(service: NetworkServiceProtocol = NetworkService(), uid: String = "") {
        self.service = service
        self.uid = AuthViewModel.shared.currentUser?.id ?? ""
        getFoodsCart()
        getTotalPrice()
        getUser()
    }
    
    func deleteFoodCart(food: Food) {
        guard let id = food.id else { return }
        service.deleteFoodCart(uid: uid, id: id)
        getFoodsCart()
    }
    
    func addFoodCart(food: Food) {
        guard let id = food.id else { return }
        service.addFoodCart(food: food, uid: uid, id: id)
        getFoodsCart()
    }
    
    func changeAmountFood(food: Food, value: MoreLess) {
        guard let id = food.id else { return }
        var count = ""
        switch value {
        case .less:
            count = String(Int(food.count ?? "1")! - 1)
        case .more:
            count = String(Int(food.count ?? "1")! + 1)
        }
        service.changeAmountFood(uid: uid, id: id, count: count)
        getFoodsCart()
    }
    
    // MARK: - Private properties
    private func getFoodsCart() {
         service.getFoodCart(id: uid) { [weak self] result in
             guard let self = self else { return }
             switch result {
             case .success(let foods):
                 self.foodsCart = foods
                 self.getTotalPrice()
             case let .failure(error):
                 self.error = error
             }
         }
     }
    
    private func getTotalPrice() {
        let total = foodsCart.compactMap { Int($0.count!)! * Int($0.price)! }
        totalPrice = String(total.reduce(0, +))
    }
    
    private func getUser() {
        service.getUser(id: uid) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                self.currentUser = user
            case let .failure(error):
                self.error = error
            }
        }
    }
}
