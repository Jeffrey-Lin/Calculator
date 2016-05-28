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
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        } else {
            display.text = digit
        }
        userIsInTheMiddleOfTyping = true
    }
    
    @IBAction private func performOperation(sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        displayValue = brain.result
    }
}

