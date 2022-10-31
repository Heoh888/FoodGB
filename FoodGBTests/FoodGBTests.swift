//
//  FoodGBTests.swift
//  FoodGBTests
//
//  Created by Алексей Ходаков on 19.10.2022.
//

import XCTest
@testable import FoodGB

final class FoodGBTests: XCTestCase {

    override func setUpWithError() throws { }
    
    
    func testgetFoods() throws {
        let service = MockNetworkService()
        let viewModel = HomeViewModel(service: service)
        XCTAssertTrue(!viewModel.foods.isEmpty)
    }
}
