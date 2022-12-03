//
//  GetOrdersOperation.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 02.12.2022.
//

import Foundation

class GetOrdersOperation: AsyncOperation {
    
    let uid: String
    var orders = [OrdersModel]()
    
    // MARK: - Properties
    private let service: NetworkServiceProtocol
    
    
    // MARK: - Functions
    override func main() {
        service.getOrderDetails(uid: uid) { orders in
            self.orders = orders
            self.state = .finished
        }
    }
    
    init(uid: String, service: NetworkServiceProtocol = NetworkService()) {
        self.uid = uid
        self.service = service
    }
}
