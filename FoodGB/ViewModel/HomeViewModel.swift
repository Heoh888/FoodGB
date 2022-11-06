//
//  HomeViewModel.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 26.10.2022.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var foods: [Food] = []
    @Published var error: Error?
    
    // MARK: - Private properties
    private var  service: NetworkServiceProtocol!
    
    // MARK: - Initialisation
    init(service: NetworkServiceProtocol = NetworkService()) {
        self.service = service
        getFoods()
    }
    
    // MARK: - Private functions
    private func getFoods() {
        service.getFoods { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let foods):
                self.foods = foods
            case let .failure(error):
                self.error = error
            }
        }
    }
}

