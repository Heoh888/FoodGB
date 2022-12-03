//
//  OrderHistoryViewModel.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 01.12.2022.
//

import Foundation


class OrderHistoryViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var orders: [OrdersModel] = []
    var uid: String = ""
    
    // MARK: - Private properties
    private var service: NetworkServiceProtocol!
    
    // MARK: - Initialisation
    init(service: NetworkServiceProtocol = NetworkService(), uid: String = "") {
        self.service = service
        self.uid = AuthViewModel.shared.currentUser?.id ?? ""
        self.getOrderHistory()
    }
    
    // MARK: - Functions
    func getOrderHistory() {
        service.getOrders(uid: uid) { orders in
            self.orders = orders
        }
    }
}
