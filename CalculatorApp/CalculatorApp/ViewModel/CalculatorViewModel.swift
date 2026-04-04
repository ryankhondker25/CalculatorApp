//
//  CalculatorViewModel.swift
//  CalculatorApp
//
//  Created by Ryan on 11/18/25.
//

import Foundation

protocol CalculatorViewModelDelegate: AnyObject {
    func updateLabel(_ value: String)
}

final class CalculatorViewModel {
    enum ResultType: Equatable {
        case number(numberResult: String)
        case error
        case none
        
        static func == (lhs: ResultType, rhs: ResultType) -> Bool {
            switch (lhs, rhs) {
            case (.number(let lhsNumber), .number(let rhsNumber)):
                return lhsNumber == rhsNumber
            case (.error, .error):
                return true
            case (.none, .none):
                return true
            default:
                return false
            }
        }
    }
    
    let calculatorButtons: [[CalculatorButtonType]] = [
        [.clear, .operation(operationType: .divide)],
        [.number(digit: 7), .number(digit: 8), .number(digit: 9), .operation(operationType: .multiply)],
        [.number(digit: 4), .number(digit: 5), .number(digit: 6), .operation(operationType: .minus)],
        [.number(digit: 1), .number(digit: 2), .number(digit: 3), .operation(operationType: .plus)],
        [.number(digit: 0), .decimalPoint, .back, .equal]
    ]
    
    var displayValue: String {
        if case let .number(numberResult) = result {
            return numberResult
        } else if result == .error {
            return "Error"
        }
        if enteredOperations.isEmpty {
            return currentNumber
        } else {
            return currentExpression
        }
    }
    
    var currentExpression: String {
        guard !enteredOperations.isEmpty else { return "" }
        
        var display = ""
        for index in (0..<enteredOperations.count) {
            display += enteredOperations[index].number
            display += enteredOperations[index].operation.titleLabel
        }
        if !currentNumber.isEmpty {
            display += currentNumber
        }
        return display
    }
    
    private var currentNumber = "0"
    private var result: ResultType = .none
    private var enteredOperations: [EnteredOperation] = []
    
    weak var delegate: CalculatorViewModelDelegate?
    
    func didPressButton(_ button: CalculatorButtonType) {
        switch button {
        case .number(let digit):
            if result != .none {
                result = .none
                resetAll()
            }
            guard !currentNumber.isEmpty else {
                currentNumber.append("\(digit)")
                delegate?.updateLabel(displayValue)
                return
            }
            if digit == 0 {
                if currentNumber == "0" {
                    return
                } else {
                    currentNumber.append("\(digit)")
                }
            } else {
                if currentNumber == "0" {
                    currentNumber = "\(digit)"
                } else {
                    currentNumber.append("\(digit)")
                }
            }
        case .decimalPoint:
            if result != .none {
                result = .none
                resetAll()
            }
            if !currentNumber.contains(".") {
                currentNumber.append(currentNumber.isEmpty ? "0." : ".")
            }
        case .clear:
            result = .none
            enteredOperations.removeAll()
            zeroCurrentNumber()
        case .back:
            guard result != .error else { return }
            if case let .number(currentResult) = result {
                currentNumber = currentResult
                enteredOperations.removeAll()
                result = .none
            }
            if !enteredOperations.isEmpty {
                if currentNumber.isEmpty {
                    let lastOperation = enteredOperations.removeLast()
                    currentNumber = lastOperation.number
                } else {
                    currentNumber.removeLast()
                }
            } else {
                let numberLength = currentNumber.isNegative() ? 2 : 1
                if currentNumber.count == numberLength {
                    zeroCurrentNumber()
                } else if currentNumber.count > numberLength {
                    currentNumber.removeLast()
                }
            }
        case .operation(let operationType):
            if case let .number(currentResult) = result {
                currentNumber = currentResult
                enteredOperations = [EnteredOperation(number: currentNumber, operation: operationType)]
                result = .none
            } else if !currentNumber.isEmpty {
                enteredOperations.append(
                    EnteredOperation(number: currentNumber, operation: operationType)
                )
            }
            resetCurrentNumber()
        case .equal:
            calculateResult()
        }
        delegate?.updateLabel(displayValue)
    }
    
    private func calculateResult() {
        guard !enteredOperations.isEmpty,
              !currentNumber.isEmpty,
              !currentExpression.isEmpty
        else { return }
        guard !containsDivisionByZero() else {
            result = .error
            resetAll()
            return
        }
        let expressionString = adjustedExpression
        let expression = NSExpression(format: expressionString)
        if let value = expression.expressionValue(with: nil, context: nil) as? Double {
            let formatter = NumberFormatter()
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 7
            let resultString = formatter.string(from: value as NSNumber) ?? "\(value)"
            result = .number(numberResult: resultString)
            if let lastOperation = enteredOperations.last {
                enteredOperations = [
                    EnteredOperation(number: resultString, operation: lastOperation.operation)
                ]
            }
        } else {
            result = .error
            resetAll()
        }
    }
    
    private func zeroCurrentNumber() {
        currentNumber = "0"
    }
    
    private func resetCurrentNumber() {
        currentNumber = ""
    }
    
    private func resetAll() {
        enteredOperations.removeAll()
        resetCurrentNumber()
    }
    
    private func containsDivisionByZero() -> Bool {
        if enteredOperations.count > 1 {
            for index in 0..<enteredOperations.count - 1 {
                if enteredOperations[index].operation == .divide && enteredOperations[index + 1].number == "0" {
                    return true
                }
            }
            if enteredOperations.last?.operation == .divide && currentNumber == "0" {
                return true
            }
        } else if enteredOperations.count == 1, let enteredOp = enteredOperations.first {
            return enteredOp.operation == .divide && currentNumber == "0"
        }
        return false
    }
    
    private var adjustedExpression: String {
        // Using * for multiplication instead of ×
        var expressionString = currentExpression.replacingOccurrences(of: "×", with: "*")
        // Formatting for division to ensure a decimal value
        // if the result is a decimal number
        if expressionString.contains("/") && !currentNumber.contains(".") {
            expressionString.append(".0")
        }
        return expressionString
    }
}

extension String {
    func isNegative() -> Bool {
        return self.first == "-"
    }
}
