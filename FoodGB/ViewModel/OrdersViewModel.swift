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
    @Published var error: Error?
    
    // MARK: - Private properties
    private var  service: NetworkServiceProtocol!
    
    // MARK: - Initialisation
    init(service: NetworkServiceProtocol = NetworkService()) {
        self.service = service
        getFoodsCart()
    }
    
    func deleteFoodCart(food: Food) {
        guard let uid = AuthViewModel.shared.currentUser?.id else { return }
        guard let id = food.id else { return }
        service.deleteFoodCart(uid: uid, id: id)
        getFoodsCart()
    }
    
    func addFoodCart(food: Food) {
        guard let uid = AuthViewModel.shared.currentUser?.id else { return }
        guard let id = food.id else { return }
        service.addFoodCart(food: food, uid: uid, id: id)
        getFoodsCart()
    }
    
    func changeAmountFood(food: Food, value: MoreLess) {
        guard let uid = AuthViewModel.shared.currentUser?.id else { return }
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
         guard let uid = AuthViewModel.shared.currentUser?.id else { return }
         service.getFoodCart(id: uid) { [weak self] result in
             guard let self = self else { return }
             switch result {
             case .success(let foods):
                 self.foodsCart = foods
             case let .failure(error):
                 self.error = error
             }
         }
     }
}
