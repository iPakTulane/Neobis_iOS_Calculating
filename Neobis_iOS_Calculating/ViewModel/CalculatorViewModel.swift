//
//  CalculatorViewModel.swift
//  Neobis_iOS_Calculating
//
//  Created by iPak Tulane on 29/11/23.
//

import Foundation

protocol CalculatorViewModelType {
    var model: CalculatorModel { get }
    var displayText: String { get }
    func buttonTapped(_ button: CalculatorButton)
}

class CalculatorViewModel: CalculatorViewModelType {
    
    private(set) var model: CalculatorModel = CalculatorModel()
    
    //для обновления модели
    var displayText: String {
        return model.displayText
    }
    
    private var isEnteringSecondNumber: Bool = false
    
    func buttonTapped(_ button: CalculatorButton) {
        switch button {
        case .clear:
            clear()
        case .plusMinus:
            changeSign()
        case .percent:
            calculatePercent()
        case .add, .subtract, .multiply, .divide:
            setOperator(button)
        case .equal:
            calculateResult()
        case .decimal:
            addDecimalPoint()
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine:
            addDigit(button)
        }
    }
    
    private func clear() {
        model.displayText = "0"
        model.operand1 = nil
        model.operand2 = nil
        model.operatorSymbol = nil
        isEnteringSecondNumber = false
    }
    
    private func changeSign() {
        if let operand = getOperandDouble() {
            let negatedValue = -operand
            model.displayText = formatNumber(negatedValue)
            setOperandDouble(negatedValue)
        }
    }
    
    private func calculatePercent() {
        if let operand = getOperandDouble() {
            let percentValue = operand / 100
            model.displayText = formatNumber(percentValue)
            setOperandDouble(percentValue)
        }
    }
    
    private func setOperator(_ button: CalculatorButton) {
        if let currentOperand = getOperandDouble() {
            //if there is a previous operation:
            if let previousOperator = model.operatorSymbol, let operand1 = model.operand1, let operand2 = model.operand2 {
                calculateIntermediateResult(operatorSymbol: previousOperator, operand1: operand1, operand2: operand2)
            } else {
                model.operand1 = currentOperand
            }
            model.operatorSymbol = button.title
            isEnteringSecondNumber = true
        }
    }
    
    private func calculateResult() {
        if let operatorSymbol = model.operatorSymbol, let operand1 = model.operand1, let operand2 = getOperandDouble() {
            calculateIntermediateResult(operatorSymbol: operatorSymbol, operand1: operand1, operand2: operand2)
            model.operatorSymbol = nil
            model.operand2 = nil
            isEnteringSecondNumber = false
        }
    }
    
    private func calculateIntermediateResult(operatorSymbol: String, operand1: Double, operand2: Double) {
        var result: Double?
        switch operatorSymbol {
        case CalculatorButton.add.title:
            result = operand1 + operand2
        case CalculatorButton.subtract.title:
            result = operand1 - operand2
        case CalculatorButton.multiply.title:
            result = operand1 * operand2
        case CalculatorButton.divide.title:
            result = operand2 != 0 ? operand1 / operand2 : nil
        default:
            break
        }
        
        if let result = result {
            model.displayText = formatNumber(result)
            model.operand1 = result
            setOperandDouble(result)
        } else {
            model.displayText = "Error"
            model.operand1 = nil
            setOperandDouble(0)
        }
    }
    
    private func addDecimalPoint() {
        if !model.displayText.contains(".") {
            model.displayText += "."
        }
    }
    
    private func addDigit(_ button: CalculatorButton) {
        let digit = button.title
        
        if isEnteringSecondNumber {
            model.displayText = digit
            isEnteringSecondNumber = false
        } else {
            if model.displayText == "0" {
                model.displayText = digit
            } else {
                model.displayText += digit
            }
        }
        model.operand2 = getOperandDouble()
    }
    
    private func getOperandDouble() -> Double? {
        return Double(model.displayText)
    }
    
    private func setOperandDouble(_ operand: Double) {
        model.displayText = formatNumber(operand)
    }
    
    private func formatNumber(_ number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 6
        return formatter.string(from: NSNumber(value: number)) ?? ""
        //        return String(format: "%.6f", number)
    }
}

