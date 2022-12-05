//
//  MyFoodsViewModel.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 12.11.2022.
//

import Foundation

class MyFoodsViewModel: ObservableObject {
    
    // MARK: - Public Properties
    @Published var like = false
    @Published var myFoods: [Food] = []
    @Published var error: Error?
    
    var uid: String = ""
    
    // MARK: - Private properties
    private let service: NetworkServiceProtocol!
    
    // MARK: - Initialisation
    init(service: NetworkServiceProtocol = NetworkService(), uid: String = "") {
        self.service = service
        self.uid = AuthViewModel.shared.currentUser?.id ?? ""
        self.getMyFoods()
    }
    
    // MARK: - Public functions
    func deleteMyFoods(id: String) {
        service.deleteMyFoods(uid: uid, id: id)
        getMyFoods()
    }
    
    func addMyFood(food: Food) {
        service.addMyFood(food: food, uid: uid, id: food.id!)
        getMyFoods()
    }
    
    func isLike(id: String) -> Bool {
        let result = myFoods.filter { $0.id == id }
        return result.count > 0
    }
    
    // MARK: - Private functions
    private func getMyFoods() {
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


