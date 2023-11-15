//
//  ViewController.swift
//  Neobis_iOS_Calculating
//
//  Created by iPak Tulane on 15/11/23.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    // MARK: -
    var value = "0"
    var runningNumber = 0
    var currentOperation: Operation = .none
    
    let buttons: [[CalculatorButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal]
    ]
    
    // MARK: -
    lazy var displayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.text = value
        label.font = UIFont.systemFont(ofSize: 100)
        label.textColor = .white
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    // MARK: -
    func setupViews() {
        view.backgroundColor = .black
        view.addSubview(displayLabel)
        view.addSubview(valueLabel)
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            // displayLabel
            displayLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            displayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            displayLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            displayLabel.heightAnchor.constraint(equalToConstant: 260),
            
            // valueLabel
            valueLabel.bottomAnchor.constraint(equalTo: displayLabel.bottomAnchor, constant: 8),
            valueLabel.trailingAnchor.constraint(equalTo: displayLabel.trailingAnchor),
        ])
        
        var topAnchor = displayLabel.bottomAnchor
        
        for row in buttons {
            let buttonStackView = UIStackView()
            buttonStackView.axis = .horizontal
            buttonStackView.distribution = .fillEqually
            buttonStackView.spacing = 12
            
            for item in row {
                let button = UIButton()
                button.setTitle(item.rawValue, for: .normal)
                button.titleLabel?.font = UIFont.systemFont(ofSize: 38)
                button.backgroundColor = item.buttonColor
                button.setTitleColor(.white, for: .normal)
                button.layer.cornerRadius = buttonWidth(item: item) / 2
                button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
                
                buttonStackView.addArrangedSubview(button)
            }
            
            view.addSubview(buttonStackView)
            buttonStackView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                buttonStackView.topAnchor.constraint(equalTo: topAnchor, constant: 3),
                buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
                buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
                buttonStackView.heightAnchor.constraint(equalToConstant: buttonHeight())
            ])
            
            topAnchor = buttonStackView.bottomAnchor
        }
    }
    
    
    // MARK: -
    @objc func didTapButton(_ sender: UIButton) {
        if let buttonText = sender.title(for: .normal),
           let button = CalculatorButton(rawValue: buttonText) {
            didTap(button: button)
        }
    }
    
    func didTap(button: CalculatorButton) {
        switch button {
        case .add, .subtract, .multiply, .divide, .equal:
            if button == .add {
                self.currentOperation = .add
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .subtract {
                self.currentOperation = .subtract
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .multiply {
                self.currentOperation = .multiply
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .divide {
                self.currentOperation = .divide
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .equal {
                let runningValue = self.runningNumber
                let currentValue = Int(self.value) ?? 0
                switch self.currentOperation {
                case .add: self.value = "\(runningValue + currentValue)"
                case .subtract: self.value = "\(runningValue - currentValue)"
                case .multiply: self.value = "\(runningValue * currentValue)"
                case .divide: self.value = "\(runningValue / currentValue)"
                case .none:
                    break
                }
            }
            
            if button != .equal {
                self.value = "0"
            }
            
        case .clear:
            self.value = "0"
        case .decimal, .negative, .percent:
            break
        default:
            let number = button.rawValue
            if self.value == "0" {
                value = number
            }
            else {
                self.value = "\(self.value)\(number)"
            }
        }
    }
    
    // MARK: -
    func buttonWidth(item: CalculatorButton) -> CGFloat {
        if item == .zero {
            return ((UIScreen.main.bounds.width - (4 * 12)) / 4) * 2
        }
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }
    
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }
    
}













