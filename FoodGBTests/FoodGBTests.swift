//
//  FoodGBTests.swift
//  FoodGBTests
//
//  Created by Алексей Ходаков on 19.10.2022.
//

import XCTest
@testable import FoodGB

final class FoodGBTests: XCTestCase {
    
    let service = MockNetworkService()
    
    // MARK: - testing ProfileViewModel
    func testLoadImage() {
        let viewModel = ProfileViewModel(service: service)
        XCTAssertNotNil(viewModel.userImage)
    }
    
    // MARK: - testing HomeViewModel
    func testGetFoods() throws {
        let viewModel = HomeViewModel(service: service)
        XCTAssertTrue(!viewModel.foods.isEmpty)
    }
    
    // MARK: - testing AuthViewModel
    func testGetUser() throws {
        let viewModel = AuthViewModel(service: service)
        XCTAssertNotNil(viewModel.currentUser)
    }
    
    func testSignout() throws {
        let viewModel = AuthViewModel(service: service)
        viewModel.signout()
        XCTAssertNil(viewModel.userSession)
    }
}
