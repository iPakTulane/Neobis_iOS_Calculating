//
//  CalculatorButton.swift
//  Neobis_iOS_Calculating
//
//  Created by iPak Tulane on 29/11/23.
//

import Foundation

enum CalculatorButton: Int {
    case clear = 0
    case plusMinus
    case percent
    case divide
    case seven
    case eight
    case nine
    case multiply
    case four
    case five
    case six
    case subtract
    case one
    case two
    case three
    case add
    case zero
    case decimal
    case equal
    
    var title: String {
        switch self {
        case .clear: return "AC"
        case .plusMinus: return "+/-"
        case .percent: return "%"
        case .divide: return "/"
        case .seven: return "7"
        case .eight: return "8"
        case .nine: return "9"
        case .multiply: return "x"
        case .four: return "4"
        case .five: return "5"
        case .six: return "6"
        case .subtract: return "-"
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        case .add: return "+"
        case .zero: return "0"
        case .decimal: return "."
        case .equal: return "="
        }
    }
}
