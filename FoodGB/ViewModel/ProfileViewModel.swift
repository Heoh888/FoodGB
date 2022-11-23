//
//  ProfileViewModel.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 19.10.2022.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var userName: String = ""
    @Published var phone = ""
    @Published var address = ""
    @Published var urlImage: String?
    @Published var userImage: Image?
    
    // MARK: - Private properties
    private let service: NetworkServiceProtocol!
    
    // MARK: - Initialisation
    init(service: NetworkServiceProtocol = NetworkService()) {
        self.service = service
        getUrlImage()
        loadImage()
    }
    
    // MARK: - Functions
    func updateUser(userName: String, phone: String, address: String, image: UIImage?, id: String) {
        service.updateUser(userName: userName,
                           phone: phone,
                           address: address,
                           image: image,
                           id: id) { url, image in
            self.userImage = Image(uiImage: image)
            self.urlImage = url
            AuthViewModel.shared.currentUser?.profileImageUrl = url
        }
    }
    
    // MARK: - Private functions
    private func getUrlImage() {
        guard let url = AuthViewModel.shared.currentUser?.profileImageUrl else { return }
        self.urlImage = url
    }
    
    private func loadImage() {
        if let url = urlImage {
            service.loadImage(url: url) { image in
                DispatchQueue.main.async {
                    self.userImage = image
                }
            }
        } else {
            userImage = Image("userImage")
        }
    }
}

