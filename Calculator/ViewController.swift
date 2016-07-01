//
//  ViewController.swift
//  Calculator
//
//  Created by Jeffrey Lin on 5/10/16.
//  Copyright © 2016 Jeffrey Lin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var display: ResultsLabel!
    @IBOutlet private weak var landscapeDisplay: ResultsLabel!
    @IBOutlet private weak var landscapeView: UIView!
    
    // Buttons with 2nd view.
    @IBOutlet private weak var eˣ: CalculatorButton!
    @IBOutlet private weak var tenˣ: CalculatorButton!
    @IBOutlet private weak var ln: CalculatorButton!
    @IBOutlet private weak var log₁₀: CalculatorButton!
    @IBOutlet private weak var sin: CalculatorButton!
    @IBOutlet private weak var cos: CalculatorButton!
    @IBOutlet private weak var tan: CalculatorButton!
    @IBOutlet private weak var sinh: CalculatorButton!
    @IBOutlet private weak var cosh: CalculatorButton!
    @IBOutlet private weak var tanh: CalculatorButton!
    
    private let brain = CalculatorBrain()
    private var userIsInTheMiddleOfTyping = false
    private var is2ndButtonPressed = false
    private var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
            landscapeDisplay.text = String(newValue)
        }
    }
    
    @IBAction private func touchDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTyping {
            display.text = display.text! + digit
            landscapeDisplay.text = landscapeDisplay.text! + digit
        } else {
            display.text = digit
            landscapeDisplay.text = digit
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
    
    @IBAction private func addDecimal(sender: UIButton) {
        let decimal = sender.currentTitle!
        
        if display.text?.rangeOfString(decimal) == nil {
            display.text = display.text! + decimal
            landscapeDisplay.text = landscapeDisplay.text! + decimal
        } else if !userIsInTheMiddleOfTyping {
            display.text = "0" + decimal
            landscapeDisplay.text = "0" + decimal
        }
        userIsInTheMiddleOfTyping = true
    }
    @IBAction private func clearDisplay(sender: UIButton) {
        display.text = "0"
        landscapeDisplay.text = "0"
        userIsInTheMiddleOfTyping = false
    }
    
    @IBAction private func view2nd(sender: UIButton) {
        is2ndButtonPressed = !is2ndButtonPressed
        
        if is2ndButtonPressed {
            eˣ.setTitle("yˣ", forState: .Normal)
            tenˣ.setTitle("2ˣ", forState: .Normal)
            ln.setTitle("logᵧ", forState: .Normal)
            log₁₀.setTitle("log₂", forState: .Normal)
            sin.setTitle("sin⁻¹", forState: .Normal)
            cos.setTitle("cos⁻¹", forState: .Normal)
            tan.setTitle("tan⁻¹", forState: .Normal)
            sinh.setTitle("sinh⁻¹", forState: .Normal)
            cosh.setTitle("cosh⁻¹", forState: .Normal)
            tanh.setTitle("tanh⁻¹", forState: .Normal)
        } else {
            eˣ.setTitle("eˣ", forState: .Normal)
            tenˣ.setTitle("10ˣ", forState: .Normal)
            ln.setTitle("ln", forState: .Normal)
            log₁₀.setTitle("log₁₀", forState: .Normal)
            sin.setTitle("sin", forState: .Normal)
            cos.setTitle("cos", forState: .Normal)
            tan.setTitle("tan", forState: .Normal)
            sinh.setTitle("sinh", forState: .Normal)
            cosh.setTitle("cosh", forState: .Normal)
            tanh.setTitle("tanh", forState: .Normal)
        }
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        setOrientation()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        setOrientation()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent        
    }
    
    private func setOrientation() {
        if UIDevice.currentDevice().orientation.isLandscape {
            landscapeView.hidden = false
        } else {
            landscapeView.hidden = true
        }
    }
}

