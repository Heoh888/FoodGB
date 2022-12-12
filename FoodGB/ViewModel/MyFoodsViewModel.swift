//
//  MyFoodsViewModel.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 12.11.2022.
//

import Foundation

class MyFoodsViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var like = false
    @Published var myFoods: [Food] = []
    @Published var error: Error?
    
    // MARK: - Private properties
    let service: NetworkServiceProtocol!
    
    // MARK: - Initialisation
    init(service: NetworkServiceProtocol = NetworkService()) {
        self.service = service
        getMyFoods()
    }
    
    func deleteMyFoods(id: String) {
        guard let uid = AuthViewModel.shared.currentUser?.id else { return }
        service.deleteMyFoods(uid: uid, id: id)
        getMyFoods()
    }
    
    func addMyFood(food: Food) {
        guard let uid = AuthViewModel.shared.currentUser?.id else { return }
        service.addMyFood(food: food, uid: uid, id: food.id!)
        getMyFoods()
    }
    
    func isLike(id: String) -> Bool {
        let result = myFoods.filter { $0.id == id }
        return result.count > 0
    }
    
    // MARK: - Private properties
    private func getMyFoods() {
         guard let uid = AuthViewModel.shared.currentUser?.id else { return }
         service.getMyFood(id: uid) { [weak self] result in
             guard let self = self else { return }
             switch result {
             case .success(let foods):
                 self.myFoods = foods
             case let .failure(error):
                 self.error = error
             }
         }
     }
}

