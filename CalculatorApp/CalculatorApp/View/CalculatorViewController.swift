//
//  CalculatorViewController.swift
//  CalculatorApp
//
//  Created by Ryan on 11/17/25.
//

import UIKit

class CalculatorViewController: UIViewController {
    private enum Constants {
        static let stackViewSpacing: CGFloat = 15
        static let stackViewHorizontalSpacing: CGFloat = 10
        static let stackViewBottomSpacing: CGFloat = 20
        static let textFieldFontSize: CGFloat = 48
        static let textFieldHeight: CGFloat = 60
        static let buttonStackSpacing: CGFloat = 20
        static let buttonHeight: CGFloat = 50
    }
    
    private let inputText: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isUserInteractionEnabled = false
        textField.font = UIFont.systemFont(ofSize: Constants.textFieldFontSize, weight: .regular)
        textField.textAlignment = .right
        textField.textColor = .label
        textField.borderStyle = .roundedRect
        textField.accessibilityIdentifier = "inputText"
        return textField
    }()
    
    private let mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 15
        return stack
    }()
    
    var viewModel = CalculatorViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        viewModel.delegate = self
        createCalculatorView()
        inputText.text = viewModel.displayValue
    }

    private func createCalculatorView() {
        mainStackView.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
        
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(inputText)
        createCalculatorButtons()
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            inputText.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight),
            mainStackView.topAnchor.constraint(
                greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor
            ),
            mainStackView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: Constants.stackViewHorizontalSpacing
            ),
            mainStackView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -Constants.stackViewHorizontalSpacing
            ),
            mainStackView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -Constants.stackViewBottomSpacing
            ),
        ])
    }
    
    private func createCalculatorButtons() {
        for array in viewModel.calculatorButtons {
            let buttonRow = UIStackView()
            buttonRow.translatesAutoresizingMaskIntoConstraints = false
            buttonRow.axis = .horizontal
            buttonRow.spacing = Constants.buttonStackSpacing
            buttonRow.distribution = .fill
            for button in array {
                let button = CalculatorButton(type: button)
                button.translatesAutoresizingMaskIntoConstraints = false
                button.addTarget(self, action: #selector(buttonPressed), for: .primaryActionTriggered)
                buttonRow.addArrangedSubview(button)
                if button.type != .clear {
                    button.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
                }
            }
            buttonRow.heightAnchor.constraint(equalToConstant: Constants.buttonHeight).isActive = true
            mainStackView.addArrangedSubview(buttonRow)
        }
    }
    
    @objc private func buttonPressed(_ sender: CalculatorButton) {
        viewModel.didPressButton(sender.type)
    }
    
    private var buttonWidth: CGFloat {
        let screenWidth = view.safeAreaLayoutGuide.layoutFrame.width
        let stackHSpacing = Constants.stackViewHorizontalSpacing
        let buttonSpacing = Constants.buttonStackSpacing
        return (screenWidth - (2 * stackHSpacing) - (3 * buttonSpacing)) / 4
    }
}

extension CalculatorViewController: CalculatorViewModelDelegate {
    func updateLabel(_ value: String) {
        inputText.text = value
    }
}
