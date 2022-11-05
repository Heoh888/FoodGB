//
//  GetImageUrlOperation.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 02.11.2022.
//

import Foundation
import SwiftUI

class GetImageUrlOperation: AsyncOperation {

    // MARK: - Properties
    let service: NetworkServiceProtocol
    var image: UIImage
    var imageUrl: String?
    
    // MARK: - Functions
    override func main() {
        service.uploaderImage(image: image) { [weak self] url in
            guard let self = self else { return }
            self.imageUrl = url
            self.state = .finished
        }
    }
    
    // MARK: - Initialisation
    init(service: NetworkServiceProtocol = NetworkService(), image: UIImage) {
        self.service = service
        self.image = image
    }
}
