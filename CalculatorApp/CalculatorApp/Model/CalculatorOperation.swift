//
//  CalculatorOperation.swift
//  CalculatorApp
//
//  Created by Ryan on 11/18/25.
//

enum CalculatorOperation: Equatable {
    case plus
    case minus
    case multiply
    case divide
    
    var titleLabel: String {
        switch self {
        case .plus:
            return "+"
        case .minus:
            return "-"
        case .multiply:
            return "×"
        case .divide:
            return "/"
        }
    }
    
    var accessibilityIdentifier: String {
        switch self {
        case .plus:
            return "+ button"
        case .minus:
            return "- button"
        case .multiply:
            return "× button"
        case .divide:
            return "/ button"
        }
    }
}
