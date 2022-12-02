//
//  GetFoodOrderOperation.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 02.12.2022.
//

import Foundation

class GetFoodOrderOperation: AsyncOperation {

    let uid: String
    
    // MARK: - Properties
    private let service: NetworkServiceProtocol
    var orders = [OrdersModel]()
    var error: Error?
    
    // MARK: - Functions
    override func main() {
        if let orders = dependencies.first as? GetOrdersOperation {
            for order in orders.orders {
                var newOrder = order
                guard let id = order.id else { return }
                service.getFoodsOrder(uid: uid, id: id) { foods in
                    newOrder.foods = foods
                    self.orders.append(newOrder)
                    self.state = .finished
                }
            }
        } else {
            self.state = .finished
        }
    }
    
    init(uid: String, service: NetworkServiceProtocol = NetworkService()) {
        self.uid = uid
        self.service = service
    }
}
