//
//  ViewController.swift
//  Neobis_iOS_Calculating
//
//  Created by iPak Tulane on 29/11/23.
//

import UIKit


class ViewController: UIViewController {
    
    private let viewModel: CalculatorViewModelType
    
    let displayLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = .systemFont(ofSize: 100)
        label.textColor = .white
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let buttons: [[CalculatorButton]] = [
        [.clear, .plusMinus, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal]
    ]
    
    init(viewModel: CalculatorViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .black
        view.addSubview(displayLabel)
        
        displayLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            displayLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            displayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            displayLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
        ])
        
        var previousRowButtons: [UIButton] = []
        
        for row in buttons {
            var rowButtons: [UIButton] = []
            var previousButton: UIButton?
            
            for calculatorButton in row {
                let button = UIButton()
                button.setTitle(calculatorButton.title, for: .normal)
                button.titleLabel?.font = UIFont.systemFont(ofSize: 33)
                button.layer.cornerRadius = widthAdapted(to: 40)
                button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
                button.tag = calculatorButton.rawValue
                view.addSubview(button)
                rowButtons.append(button)
                
                switch calculatorButton {
                case .clear, .plusMinus, .percent:
                    button.backgroundColor = .lightGray
                    button.setTitleColor(.black, for: .normal)
                case .add, .subtract, .multiply, .divide, .equal:
                    button.backgroundColor = .orange
                default:
                    button.backgroundColor = .darkGray
                }
                
                button.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    button.heightAnchor.constraint(equalToConstant: widthAdapted(to: 80)),
                ])
                
                if calculatorButton == .zero {
                    NSLayoutConstraint.activate([
                        button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5, constant: -15),
                    ])
                } else {
                    NSLayoutConstraint.activate([
                        button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25, constant: -17),
                    ])
                }
                
                if let previousButton = previousButton {
                    NSLayoutConstraint.activate([
                        button.leadingAnchor.constraint(equalTo: previousButton.trailingAnchor, constant: 13),
                    ])
                } else {
                    NSLayoutConstraint.activate([
                        button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17),
                    ])
                }
                
                if previousRowButtons.isEmpty {
                    NSLayoutConstraint.activate([
                        button.topAnchor.constraint(equalTo: displayLabel.bottomAnchor, constant: 17),
                    ])
                } else {
                    NSLayoutConstraint.activate([
                        button.topAnchor.constraint(equalTo: previousRowButtons.last!.bottomAnchor, constant: 13),
                    ])
                }
                
                if row == buttons.last {
                    NSLayoutConstraint.activate([
                        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -35),
                    ])
                }
                
                previousButton = button
            }
            
            previousRowButtons = rowButtons
        }
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        guard let button = CalculatorButton(rawValue: sender.tag) else {
            return
        }
        viewModel.buttonTapped(button)
        displayLabel.text = viewModel.displayText
    }
}


//class ViewController: UIViewController {
//    
//    private let viewModel: CalculatorViewModelType
//    
//    let displayLabel: UILabel = {
//        let label = UILabel()
//        label.text = "0"
//        label.font = .systemFont(ofSize: 100)
//        label.textColor = .white
//        label.textAlignment = .right
//        label.adjustsFontSizeToFitWidth = true
//        return label
//    }()
//    
//    private let buttons: [[CalculatorButton]] = [
//        [.clear, .plusMinus, .percent, .divide],
//        [.seven, .eight, .nine, .multiply],
//        [.four, .five, .six, .subtract],
//        [.one, .two, .three, .add],
//        [.zero, .decimal, .equal]
//    ]
//    
//    init(viewModel: CalculatorViewModelType) {
//        self.viewModel = viewModel
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        setupViews()
//    }
//    
//    private func setupViews() {
//        view.backgroundColor = .black
//        view.addSubview(displayLabel)
//    
//        displayLabel.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            displayLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
//            displayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
//            displayLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
//        ])
//        
//    }
//        
//        var previousRowButtons: [UIButton] = []
//        
//        for row in buttons {
//            var rowButtons: [UIButton] = []
//            var previousButton: UIButton?
//            
//            for calculatorButton in row {
//                let button = UIButton()
//                button.setTitle(calculatorButton.title, for: .normal)
//                button.titleLabel?.font = UIFont.systemFont(ofSize: 33)
//                button.layer.cornerRadius = widthAdapted(to: 40)
//                button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
//                button.tag = calculatorButton.rawValue
//                view.addSubview(button)
//                rowButtons.append(button)
//                    switch calculatorButton {
//                    case .clear, .plusMinus, .percent:
//                        button.layer.backgroundColor = UIColor.lightGray.cgColor
//                        button.setTitleColor(.black, for: .normal)
//                    case .add, .subtract, .multiply, .divide, .equal:
//                        button.layer.backgroundColor = UIColor.orange.cgColor
//                    default:
//                        button.layer.backgroundColor = UIColor.darkGray.cgColor
//                    }
//                
//                button.snp.makeConstraints { make in
//                    make.height.equalTo(widthAdapted(to: 80))
//                    if calculatorButton == .zero {
//                        make.width.equalToSuperview().multipliedBy(0.5).offset(-15)
//                    } else {
//                        make.width.equalToSuperview().multipliedBy(0.25).offset(-17)
//                    }
//                    
//                    if let previousButton = previousButton {
//                        make.leading.equalTo(previousButton.snp.trailing).offset(13)
//                    } else {
//                        make.leading.equalToSuperview().offset(17)
//                    }
//                    
//                    if previousRowButtons.isEmpty {
//                        make.top.equalTo(displayLabel.snp.bottom).offset(17)
//                    } else {
//                        make.top.equalTo(previousRowButtons.last!.snp.bottom).offset(13)
//                    }
//                    if row == buttons.last {
//                        make.bottom.equalTo(view.snp.bottom).offset(-35)
//                    }
//                }
//                previousButton = button
//            }
//            previousRowButtons = rowButtons
//        }
//    }
//    
//    @objc private func buttonTapped(_ sender: UIButton) {
//        guard let button = CalculatorButton(rawValue: sender.tag) else {
//            return
//        }
//        viewModel.buttonTapped(button)
//        displayLabel.text = viewModel.displayText
//    }
//}
//
