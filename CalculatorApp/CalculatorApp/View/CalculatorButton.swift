//
//  CalculatorButton.swift
//  CalculatorApp
//
//  Created by Ryan on 11/18/25.
//

import UIKit

final class CalculatorButton: UIButton {
    private enum Constants {
        static let cornerRadius: CGFloat = 10
        static let titleFontSize: CGFloat = 20
    }
    
    let type: CalculatorButtonType
    
    init(type: CalculatorButtonType) {
        self.type = type
        super.init(frame: .zero)
        
        setupButton()
        accessibilityIdentifier = type.accessibilityIdentifier
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.font = UIFont.systemFont(ofSize: Constants.titleFontSize, weight: .regular)
    }
    
    private func setupButton() {
        var buttonConfiguration = UIButton.Configuration.filled()
        buttonConfiguration.title = type.titleLabel
        buttonConfiguration.baseBackgroundColor = type.backgroundColor
        buttonConfiguration.baseForegroundColor = type.tintColor
        buttonConfiguration.background.cornerRadius = Constants.cornerRadius
        
        var highlightedConfiguration = buttonConfiguration
        highlightedConfiguration.baseBackgroundColor = type.highlightedColor
        
        self.configuration = buttonConfiguration
        configurationUpdateHandler = { button in
            button.configuration = button.isHighlighted ? highlightedConfiguration : buttonConfiguration
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
