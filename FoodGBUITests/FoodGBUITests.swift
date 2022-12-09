//
//  FoodGBUITests.swift
//  FoodGBUITests
//
//  Created by Алексей Ходаков on 19.10.2022.
//

import XCTest
import SwiftUI
@testable import FoodGB


final class FoodGBUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    // Рандомная строка добавляется `Name` и `Email address` пользователя
    var randomString = String((0..<5).map{ _ in "abcdefghijklmnopqrstuvwxyz".randomElement()! })
    
    override func setUp() {
        app = XCUIApplication()
        app.launch()
        
        let buttonStart = app.buttons["start button"].firstMatch
        buttonStart.tap()
    }
    
    /// Функция `test Auth View` сначала она создает аккаунт а потом логинится под ним
    /// - Warning: чтобы функция корректно работала в симуляторе нужно отключить опцию сохранение пароля
    func testAuthView() {
        
        // MARK: - Registration View
        let buttonRegistration = app.buttons["Registration button"].firstMatch
        buttonRegistration.tap()
        
        let name = app.textFields["Registration Name"]
        name.tap()
        name.typeText("Test\(randomString)")
        
        let emailAddressRegistration = app.textFields["Registration Email address"]
        emailAddressRegistration.tap()
        emailAddressRegistration.typeText("test_\(randomString)@mustDeleted.ru")
        
        let passwordRegistration = app.secureTextFields["Registration Password"]
        passwordRegistration.tap()
        passwordRegistration.typeText("TJFJFEUFHEF")
        
        app.tap() // сброс клавиатуры
        
        var buttonAuthentication = app.buttons["Register Button"].firstMatch
        buttonAuthentication.tap()
        
        let menu = app.buttons["Menu"].firstMatch
        XCTAssertTrue(menu.waitForExistence(timeout: 10))
        menu.tap()
        
        let signOutButton = app.buttons["Sign-out"].firstMatch
        signOutButton.tap()
        
        
        // MARK: - Login View
        let buttonLogin = app.buttons["Login button"].firstMatch
        XCTAssertTrue(buttonLogin.waitForExistence(timeout: 10))
        buttonLogin.tap()
        
        let emailAddress = app.textFields["Login Email address"]
        emailAddress.tap()
        emailAddress.typeText("test_\(randomString)@mustDeleted.ru")
        
        let password = app.secureTextFields["Login Password"]
        password.tap()
        password.typeText("TJFJFEUFHEF")
        
        app.tap() // сброс клавиатуры
        
        buttonAuthentication = app.buttons["Login Button"].firstMatch
        buttonAuthentication.tap()

        XCTAssertTrue(menu.waitForExistence(timeout: 10))
        menu.tap()
        signOutButton.tap()
        
        XCTAssertTrue(buttonLogin.waitForExistence(timeout: 10))
    }
}
