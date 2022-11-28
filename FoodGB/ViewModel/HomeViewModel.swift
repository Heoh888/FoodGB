//
//  HomeViewModel.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 26.10.2022.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var typeFoods: [String] = ["All"]
    @Published var foods: [Food] = []
    @Published var error: Error?
    @Published var filteredFoods: [Food] = []
    
    @Published var searchText: String = ""
    @Published var searchActivated: Bool = false
    @Published var searchedFoods: [Food]?
    var searchCancellable: AnyCancellable?
    
    // MARK: - Private properties
    private var  service: NetworkServiceProtocol!
    
    // MARK: - Initialisation
    init(service: NetworkServiceProtocol = NetworkService()) {
        self.service = service
        searchCancellable = $searchText
            .removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: { str in
                if str != "" {
                    self.searchedProducts()
                } else {
                    self.searchedFoods = nil
                }
            })
        getFoods()
    }
    
    // MARK: - Functions
    func filteredFoodsByType(type: String) {
        if type == "All" {
            self.filteredFoods = self.foods
        } else {
            self.filteredFoods = self.foods.filter { product in product.type == type }
        }
    }
    
    func searchedProducts() {
        searchedFoods = foods.filter { $0.name.lowercased().contains(searchText.lowercased())}
    }
    
    // MARK: - Private functions
    private func getFoods() {
        service.getFoods { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let foods):
                self.foods = foods
                self.getTypeFoods(foods: foods)
                self.filteredFoodsByType(type: "All")
            case let .failure(error):
                self.error = error
            }
        }
    }
    
    private func getTypeFoods(foods: [Food]) {
        for food in foods {
            guard let type = food.type else { continue }
            if !typeFoods.contains(type) {
                typeFoods.append(type)
            }
        }
    }
}

