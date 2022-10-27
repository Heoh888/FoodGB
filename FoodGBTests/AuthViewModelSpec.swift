//
//  AuthViewModelSpec.swift
//  FoodGBTests
//
//  Created by Алексей Ходаков on 25.10.2022.
//

import XCTest
@testable import FoodGB

final class AuthViewModelSpec: XCTestCase {
    
    var viewModel: AuthViewModel!
    var mockNetworkService: MockNetworkService!

    override func setUpWithError() throws {
        mockNetworkService = MockNetworkService()
        viewModel = .init(service: mockNetworkService)
    }
    
    func testLoginWithCorrectDetailsSetsSuccessPresentedToTrue() {
        viewModel.login(withEmail: "", password: "")
        
        XCTAssertNotNil(viewModel.userSession)
    }
}
