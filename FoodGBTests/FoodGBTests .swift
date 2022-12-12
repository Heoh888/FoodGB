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
    
    // MARK: - testing OrderHistoryViewModel
    func testLoadImage() {
        let viewModel = OrderHistoryViewModel(service: service)
        XCTAssertNotNil(viewModel.orders)
    }

    
    // MARK: - testing ProfileViewModel
    func testGetOrderHistory() {
        let viewModel = ProfileViewModel(service: service)
        XCTAssertNotNil(viewModel.userImage)
    }
    
    func testUpdateUser() {
        let viewModel = ProfileViewModel(service: service)
        
        viewModel.updateUser(userName: "testName",
                             phone: "testPhone",
                             address: "testAddress",
                             image: UIImage(named: "card")!,
                             id: "tetsId")
        
        XCTAssertNotNil(viewModel.userImage)
        XCTAssertNotNil(viewModel.urlImage)
    }
    
    // MARK: - testing HomeViewModel
    func testGetFoods() throws {
        let viewModel = HomeViewModel(service: service)
        XCTAssertTrue(!viewModel.foods.isEmpty)
    }
    
    func testGetTypeFoods() throws {
        let viewModel = HomeViewModel(service: service)
        viewModel.filteredFoodsByType(type: "Food")
        let check = viewModel.foods.map { $0.type == "Food" ? true : false }
        XCTAssertTrue(check.allSatisfy({$0}))
    }
    
    func testSearchedProducts() throws {
        let viewModel = HomeViewModel(service: service)
        viewModel.searchText = "T"
        viewModel.searchedProducts()
        XCTAssertNotNil(viewModel.searchedFoods)
    }
    
    // MARK: - testing AuthViewModel
    func testSignout() throws {
        let viewModel = AuthViewModel(service: service)
        viewModel.signout()
        XCTAssertNil(viewModel.userSession)
    }
    
    // MARK: - testing MyFoodsViewModel
    func testGetMyFoods() {
        let viewModel = MyFoodsViewModel(service: service, uid: "tets")
        XCTAssertTrue(!viewModel.myFoods.isEmpty)
    }
    
    func testIsLike() {
        let viewModel = MyFoodsViewModel(service: service, uid: "test")
        let result = viewModel.isLike(id: "test")
        XCTAssertTrue(result)
    }
    
    func testAddMyFood() {
        let viewModel = MyFoodsViewModel(service: service, uid: "tets")
        
        viewModel.myFoods = []
        
        let food = Food(name: "test",
                        description: "test",
                        foodImageUrl: "test",
                        price: "test",
                        id: "test")
        
        viewModel.addMyFood(food: food)
        
        XCTAssertTrue(!viewModel.myFoods.isEmpty)
    }
    
    // MARK: - testing OrdersViewModel
    func testGetUserOrdersView() throws {
        let viewModel = OrdersViewModel(service: service)
        XCTAssertNotNil(viewModel.currentUser)
    }
    
    func testAddFoodCart() throws {
        let viewModel = OrdersViewModel(service: service)
        
        viewModel.foodsCart = []
        
        let food = Food(name: "test",
                        description: "test",
                        foodImageUrl: "test",
                        price: "test",
                        id: "test")
        
        viewModel.addFoodCart(food: food)
        
        XCTAssertTrue(!viewModel.foodsCart.isEmpty)
    }
    
    func testChangeAmountFood() throws {
        let viewModel = OrdersViewModel(service: service)
        
        viewModel.foodsCart = []
        
        let food = Food(name: "test",
                        description: "test",
                        foodImageUrl: "test",
                        price: "test",
                        id: "test")
        
        viewModel.changeAmountFood(food: food, value: .more)
        
        XCTAssertTrue(!viewModel.foodsCart.isEmpty)
    }
    
    func testGetTotalPrice() throws {
        let viewModel = OrdersViewModel(service: service)
        XCTAssertTrue(viewModel.totalPrice != "")
    }
    
    // MARK: - testing CheckoutOrdrersViewModel
    func testAddDitails() throws {
        let viewModel = CheckoutOrdrersViewModel(service: service)
        viewModel.addDitails(key: "Payment method", value: "test")
        XCTAssertTrue(viewModel.ditails["Payment method"] == "test")
    }
}
