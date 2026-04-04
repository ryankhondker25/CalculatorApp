//
//  CalculatorButtonTests.swift
//  CalculatorAppTests
//
//  Created by Ryan on 11/17/25.
//

@testable import CalculatorApp
import XCTest

final class CalculatorButtonTests: XCTestCase {
    func testDigitButton() {
        // Given, When
        let button = CalculatorButton(type: .number(digit: 1))
        
        // Then
        XCTAssertEqual(button.configuration?.title, "1")
    }
    
    func testDecimalButton() {
        // Given, When
        let button = CalculatorButton(type: .decimalPoint)
        
        // Then
        XCTAssertEqual(button.configuration?.title, ".")
    }
    
    func testBackButton() {
        // Given, When
        let button = CalculatorButton(type: .back)
        
        // Then
        XCTAssertEqual(button.configuration?.title, "Back")
    }
    
    func testClearButton() {
        // Given, When
        let button = CalculatorButton(type: .clear)
        
        // Then
        XCTAssertEqual(button.configuration?.title, "AC")
    }
    
    func testPlusButton() {
        // Given, When
        let button = CalculatorButton(type: .operation(operationType: .plus))
        
        // Then
        XCTAssertEqual(button.configuration?.title, "+")
    }
    
    func testMinusButton() {
        // Given, When
        let button = CalculatorButton(type: .operation(operationType: .minus))
        
        // Then
        XCTAssertEqual(button.configuration?.title, "-")
    }
    
    func testMultiplyButton() {
        // Given, When
        let button = CalculatorButton(type: .operation(operationType: .multiply))
        
        // Then
        XCTAssertEqual(button.configuration?.title, "×")
    }
    
    func testDivideButton() {
        // Given, When
        let button = CalculatorButton(type: .operation(operationType: .divide))
        
        // Then
        XCTAssertEqual(button.configuration?.title, "/")
    }
    
    func testEqualButton() {
        // Given, When
        let button = CalculatorButton(type: .equal)
        
        // Then
        XCTAssertEqual(button.configuration?.title, "=")
    }
}
