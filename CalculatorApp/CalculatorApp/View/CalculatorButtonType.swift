//
//  CalculatorButtonType.swift
//  CalculatorApp
//
//  Created by Ryan Khondker on 4/3/26.
//

import UIKit

enum CalculatorButtonType: Equatable {
    case number(digit: Int)
    case decimalPoint
    case clear
    case back
    case operation(operationType: CalculatorOperation)
    case equal
    
    var titleLabel: String {
        switch self {
        case .number(let digit):
            return "\(digit)"
        case .decimalPoint:
            return "."
        case .clear:
            return "AC"
        case .back:
            return "Back"
        case .operation(let operationType):
            return operationType.titleLabel
        case .equal:
            return "="
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .number, .decimalPoint, .clear, .back:
            return .systemGray3
        case .operation, .equal:
            return .orange
        }
    }
    
    var highlightedColor: UIColor {
        switch self {
        case .number, .decimalPoint, .clear, .back:
            return .systemGray5
        case .operation, .equal:
            return .systemOrange
        }
    }
    
    var tintColor: UIColor {
        switch self {
        case .number, .decimalPoint, .clear, .back:
            return .label
        case .operation, .equal:
            return .white
        }
    }
    
    var accessibilityIdentifier: String {
        switch self {
        case .number(let digit):
            return "\(digit) button"
        case .decimalPoint:
            return ". button"
        case .clear:
            return "clearButton"
        case .back:
            return "backButton"
        case .operation(let operationType):
            return operationType.accessibilityIdentifier
        case .equal:
            return "= button"
        }
    }
}
