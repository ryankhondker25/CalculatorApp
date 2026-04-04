//
//  CalculatorViewModelTests.swift
//  CalculatorApp
//
//  Created by Ryan on 11/18/25.
//

@testable import CalculatorApp
import XCTest

final class CalculatorViewModelTests: XCTestCase {
    func testInitialState() {
        // Given, When
        let vm = CalculatorViewModel()
        let mockDelegate = MockCalculatorViewModelDelegate()
        vm.delegate = mockDelegate
        
        XCTAssertEqual(mockDelegate.value, "0")
    }
    
    func testDidPressDigitButton() {
        // Given
        let vm = CalculatorViewModel()
        let mockDelegate = MockCalculatorViewModelDelegate()
        vm.delegate = mockDelegate
        
        // When
        vm.didPressButton(.number(digit: 1))
        
        // Then
        XCTAssertEqual(mockDelegate.value, "1")
    }
    
    func testDidPressDecimalButton() {
        // Given
        let vm = CalculatorViewModel()
        let mockDelegate = MockCalculatorViewModelDelegate()
        vm.delegate = mockDelegate
        
        // When
        vm.didPressButton(.decimalPoint)
        
        // Then
        XCTAssertEqual(mockDelegate.value, "0.")
    }
    
    func testDidPressBackButton() {
        // Given
        let vm = CalculatorViewModel()
        let mockDelegate = MockCalculatorViewModelDelegate()
        vm.delegate = mockDelegate
        
        // When
        vm.didPressButton(.number(digit: 1))
        vm.didPressButton(.number(digit: 5))
        vm.didPressButton(.number(digit: 0))
        vm.didPressButton(.back)
        
        // Then
        XCTAssertEqual(mockDelegate.value, "15")
    }
    
    func testDidPressOperation() {
        // Given
        let vm = CalculatorViewModel()
        let mockDelegate = MockCalculatorViewModelDelegate()
        vm.delegate = mockDelegate
        
        // When
        vm.didPressButton(.number(digit: 1))
        vm.didPressButton(.number(digit: 5))
        vm.didPressButton(.operation(operationType: .plus))
        vm.didPressButton(.number(digit: 2))
        
        // Then
        XCTAssertEqual(mockDelegate.value, "15+2")
    }
    
    func testDidPressOperationConsecutively() {
        // Given
        let vm = CalculatorViewModel()
        let mockDelegate = MockCalculatorViewModelDelegate()
        vm.delegate = mockDelegate
        
        // When
        vm.didPressButton(.number(digit: 1))
        vm.didPressButton(.number(digit: 5))
        vm.didPressButton(.operation(operationType: .plus))
        vm.didPressButton(.operation(operationType: .plus))
        
        // Then
        XCTAssertEqual(mockDelegate.value, "15+")
    }
    
    func testDidPressEqual() {
        // Given
        let vm = CalculatorViewModel()
        let mockDelegate = MockCalculatorViewModelDelegate()
        vm.delegate = mockDelegate
        
        // When
        vm.didPressButton(.number(digit: 1))
        vm.didPressButton(.number(digit: 5))
        vm.didPressButton(.operation(operationType: .plus))
        vm.didPressButton(.number(digit: 1))
        vm.didPressButton(.equal)
        
        // Then
        XCTAssertEqual(mockDelegate.value, "17")
    }
    
    func testDidPressClear() {
        // Given
        let vm = CalculatorViewModel()
        let mockDelegate = MockCalculatorViewModelDelegate()
        vm.delegate = mockDelegate
        
        // When
        vm.didPressButton(.number(digit: 1))
        vm.didPressButton(.number(digit: 5))
        vm.didPressButton(.operation(operationType: .plus))
        vm.didPressButton(.number(digit: 1))
        vm.didPressButton(.equal)
        vm.didPressButton(.clear)
        
        // Then
        XCTAssertEqual(mockDelegate.value, "0")
    }
    
    func testDivideByZero() {
        // Given
        let vm = CalculatorViewModel()
        let mockDelegate = MockCalculatorViewModelDelegate()
        vm.delegate = mockDelegate
        
        // When
        vm.didPressButton(.number(digit: 1))
        vm.didPressButton(.number(digit: 5))
        vm.didPressButton(.operation(operationType: .divide))
        vm.didPressButton(.number(digit: 0))
        vm.didPressButton(.equal)
        
        // Then
        XCTAssertEqual(mockDelegate.value, "Error")
    }
}

final class MockCalculatorViewModelDelegate: CalculatorViewModelDelegate {
    var value = ""
    
    func updateLabel(_ value: String) {
        self.value = value
    }
}
