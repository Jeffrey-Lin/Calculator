//
//  ViewController.swift
//  Calculator
//
//  Created by Jeffrey Lin on 5/10/16.
//  Copyright © 2016 Jeffrey Lin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var display: ResultsLabelViewController!
        
    private let brain = CalculatorBrain()
    private var userIsInTheMiddleOfTyping = false
    private var userAlreadyEnteredDecimal = false
    private var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    @IBAction private func touchDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTyping {
            display.text = display.text! + digit
        } else {
            display.text = digit
        }
        userIsInTheMiddleOfTyping = true
    }
    
    @IBAction private func performOperation(sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
            userAlreadyEnteredDecimal = false
        }
        
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        displayValue = brain.result
    }
    
    @IBAction func addDecimal(sender: UIButton) {
        let decimal = sender.currentTitle!
        
        if !userAlreadyEnteredDecimal {
            if userIsInTheMiddleOfTyping {
                display.text = display.text! + decimal
            } else {
                display.text = "0" + decimal
            }
        }
        userIsInTheMiddleOfTyping = true
        userAlreadyEnteredDecimal = true
    }
    
    @IBAction func clearDisplay(sender: UIButton) {
        displayValue = 0
    }
}

