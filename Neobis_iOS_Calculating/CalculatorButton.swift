//
//  CalculatorButton.swift
//  Neobis_iOS_Calculating
//
//  Created by iPak Tulane on 15/11/23.
//

import UIKit

enum CalculatorButton: String {
    case zero = "0"
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case equal = "="
    case add = "+"
    case subtract = "-"
    case multiply = "x"
    case divide = "÷"
    case decimal = ","
    case clear = "AC"
    case negative = "±"
    case percent = "%"
    
    // To color buttons appropriately
    var buttonColor: UIColor {
        switch self {
        case .add, .subtract, .multiply, .divide, .equal:
            return UIColor.orange
        case .clear, .negative, .percent:
            return UIColor.lightGray
        default:
            return UIColor.darkGray
        }
    }
}
