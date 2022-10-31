//
//  ProfileViewModel.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 19.10.2022.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    
    @Published var imageUrl: String?
    @Published var error: Error?
    
    // MARK: - Properties
    private let service: NetworkServiceProtocol!
    
    // MARK: - Initialisation
    init(service: NetworkServiceProtocol = NetworkService()) {
        self.service = service
        self.imageUrl = AuthViewModel.shared.currentUser?.profileImageUrl
    }
    
    // MARK: - Functions
    
    func updateUser(userName: String, phone: String, address: String, image: UIImage?) {
        service.updateUser(userName: userName, phone: phone, address: address, image: image) { url in
            self.imageUrl = url
        }
    }
}
