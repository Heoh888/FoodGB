//
//  UplouderDataOperation.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 02.11.2022.
//

import Foundation

class UplouderDataOperation: AsyncOperation {
    
    // MARK: - Properties
    private let service: NetworkServiceProtocol
    let id: String
    var data: [String : String]
    var urlImage: String?

    // MARK: - Functions
    override func main() {
        if let imageUrl = dependencies.first as? ImageUploaderOperation {
            data["profileImageUrl"] = imageUrl.imageUrl
            service.updateData(data: data, id: id)
            urlImage = imageUrl.imageUrl
            self.state = .finished
        } else {
            data["profileImageUrl"] = AuthViewModel.shared.currentUser?.profileImageUrl
            service.updateData(data: data, id: id)
            self.state = .finished
        }
    }
    
    // MARK: - Initialisation
    init(service: NetworkServiceProtocol = NetworkService(), id: String, data: [String : String]) {
        self.service = service
        self.id = id
        self.data = data
    }
}
