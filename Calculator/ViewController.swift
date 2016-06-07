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
    @IBOutlet weak var landscapeView: UIView!
        
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
        }
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        displayValue = brain.result
    }
    
    @IBAction func addDecimal(sender: UIButton) {
        let decimal = sender.currentTitle!
        
        if display.text?.rangeOfString(decimal) == nil {
            display.text = display.text! + decimal
        } else if !userIsInTheMiddleOfTyping {
            display.text = "0" + decimal
        }
        userIsInTheMiddleOfTyping = true
    }
    @IBAction func clearDisplay(sender: UIButton) {
        display.text = "0"
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        setOrientation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setOrientation()
    }
    
    private func setOrientation() {
        if UIDevice.currentDevice().orientation.isLandscape {
            landscapeView.hidden = false
        } else {
            landscapeView.hidden = true
        }
    }
}

