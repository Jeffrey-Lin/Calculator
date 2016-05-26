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
        "√": Operation.unaryOperation(sqrt),
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