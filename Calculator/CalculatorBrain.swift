//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Jeffrey Lin on 5/12/16.
//  Copyright © 2016 Jeffrey Lin. All rights reserved.
//

import Foundation

class CalculatorBrain {
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
    }
    
    private struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    private var accumulator = 0.0
    private var pendingInfo: PendingBinaryOperationInfo?
    private var operations = [
        "π": Operation.constant(M_PI),
        "e": Operation.constant(M_E),
        "%": Operation.unaryOperation({ $0/100 }),
        "ᐩ⁄-": Operation.unaryOperation({ -$0 }),
        "x²": Operation.unaryOperation({ pow($0, 2) }),
        "x³": Operation.unaryOperation({ pow($0, 3) }),
        "eˣ": Operation.unaryOperation({ pow(M_E, $0) }),
        "10ˣ": Operation.unaryOperation({ pow(10, $0) }),
        "¹ ⁄ₓ": Operation.unaryOperation({ 1/$0 }),
        "²√x": Operation.unaryOperation(sqrt),
        "³√x": Operation.unaryOperation({ pow($0, 1/3) }),
        "ln": Operation.unaryOperation({ log($0)/log(M_E) }),
        "log₁₀": Operation.unaryOperation(log10),
        // factorial here
        "sin": Operation.unaryOperation(sin), // radians
        "cos": Operation.unaryOperation(cos), // radians
        "tan": Operation.unaryOperation(tan), // radians
        "sinh": Operation.unaryOperation(sinh), // radians
        "cosh": Operation.unaryOperation(cosh), // radians
        "tanh": Operation.unaryOperation(tanh), // radians
        "Rand": Operation.unaryOperation({ _ in Double(arc4random()) / Double(UINT32_MAX) }),
        "×": Operation.binaryOperation(*),
        "÷": Operation.binaryOperation(/),
        "−": Operation.binaryOperation(-),
        "+": Operation.binaryOperation(+),
        "=": Operation.equals
    ]
    
    var result: Double {
        get {
            return accumulator
        }
    }
    
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
    func performOperation(symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let function):
                accumulator = function(accumulator)
            case .binaryOperation(let function):
                executePendingBinaryOperation()
                pendingInfo = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .equals:
                executePendingBinaryOperation()
            }
        }
    }
    
    private func executePendingBinaryOperation() {
        if let pending = pendingInfo {
            accumulator = pending.binaryFunction(pending.firstOperand, accumulator)
            pendingInfo = nil
        }
    }
}