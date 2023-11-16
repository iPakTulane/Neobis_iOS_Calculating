//
//  ViewController.swift
//  Neobis_iOS_Calculating
//
//  Created by iPak Tulane on 15/11/23.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    // MARK: -
    var value = "0" // default value to display
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
        
        // MARK: -
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
        
        // MARK: -
        var topAnchor = displayLabel.bottomAnchor
        
        for row in buttons {
            let buttonsHStackView = UIStackView()
            buttonsHStackView.axis = .horizontal
            buttonsHStackView.spacing = 12
            buttonsHStackView.translatesAutoresizingMaskIntoConstraints = false
            
            if row.count == 3 {
                buttonsHStackView.distribution = .fillProportionally
                
                // Create the first button in the last row
                let zeroButton = UIButton()
                zeroButton.setTitle(row[0].rawValue, for: .normal)
                zeroButton.titleLabel?.font = UIFont.systemFont(ofSize: 38)
                zeroButton.backgroundColor = row[0].buttonColor
                zeroButton.setTitleColor(.white, for: .normal)
                zeroButton.layer.cornerRadius = 40
                zeroButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
                zeroButton.translatesAutoresizingMaskIntoConstraints = false
                buttonsHStackView.addArrangedSubview(zeroButton)
                
                // Create the second button in the last row
                let decimalButton = UIButton()
                decimalButton.setTitle(row[1].rawValue, for: .normal)
                decimalButton.titleLabel?.font = UIFont.systemFont(ofSize: 38)
                decimalButton.backgroundColor = row[1].buttonColor
                decimalButton.setTitleColor(.white, for: .normal)
                decimalButton.layer.cornerRadius = buttonWidth(item: row[1]) / 2
                decimalButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
                decimalButton.translatesAutoresizingMaskIntoConstraints = false
                buttonsHStackView.addArrangedSubview(decimalButton)
                                
                // Create the third button in the last row
                let equalButton = UIButton()
                equalButton.setTitle(row[2].rawValue, for: .normal)
                equalButton.titleLabel?.font = UIFont.systemFont(ofSize: 38)
                equalButton.backgroundColor = row[2].buttonColor
                equalButton.setTitleColor(.white, for: .normal)
                equalButton.layer.cornerRadius = buttonWidth(item: row[2]) / 2
                equalButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
                equalButton.translatesAutoresizingMaskIntoConstraints = false
                buttonsHStackView.addArrangedSubview(equalButton)
                
                NSLayoutConstraint.activate([
                    // zeroButton
                    zeroButton.centerYAnchor.constraint(equalTo: buttonsHStackView.centerYAnchor),
                    zeroButton.leadingAnchor.constraint(equalTo: buttonsHStackView.leadingAnchor, constant: 5),
                    zeroButton.widthAnchor.constraint(equalToConstant: ((UIScreen.main.bounds.width - (4 * 12)) / 4) * 2),
                    // decimalButton
                    decimalButton.centerYAnchor.constraint(equalTo: buttonsHStackView.centerYAnchor),
                    decimalButton.trailingAnchor.constraint(equalTo: equalButton.leadingAnchor, constant: -10),
                    decimalButton.widthAnchor.constraint(equalToConstant: ((UIScreen.main.bounds.width - (4 * 12)) / 4)),
                    // equalButton
                    equalButton.centerYAnchor.constraint(equalTo: buttonsHStackView.centerYAnchor),
                    equalButton.trailingAnchor.constraint(equalTo: buttonsHStackView.trailingAnchor),
                    equalButton.widthAnchor.constraint(equalToConstant: ((UIScreen.main.bounds.width - (4 * 12)) / 4)),
                ])
                
            } else {
                
                // For upper rows, use fillEqually distribution
                buttonsHStackView.distribution = .fillEqually
                for item in row {
                    let button = UIButton()
                    button.setTitle(item.rawValue, for: .normal)
                    button.titleLabel?.font = UIFont.systemFont(ofSize: 38)
                    button.backgroundColor = item.buttonColor
                    button.setTitleColor(.white, for: .normal)
                    button.layer.cornerRadius = buttonWidth(item: item) / 2
                    button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
                    button.translatesAutoresizingMaskIntoConstraints = false
                    buttonsHStackView.addArrangedSubview(button)
                }
            }
            
            view.addSubview(buttonsHStackView)
            
            NSLayoutConstraint.activate([
                buttonsHStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
                buttonsHStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
                buttonsHStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
                buttonsHStackView.heightAnchor.constraint(equalToConstant: buttonHeight()),
            ])
            
            topAnchor = buttonsHStackView.bottomAnchor
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
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }
    
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }
    
}
