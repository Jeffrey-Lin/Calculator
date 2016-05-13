//
//  ViewController.swift
//  Calculator
//
//  Created by Jeffrey Lin on 5/10/16.
//  Copyright © 2016 Jeffrey Lin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var display: UILabel!
    @IBOutlet weak var zeroButton: UIButton!
    
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
        var digit = sender.currentTitle!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        zeroButton.titleLabel?.hidden = true
    }
}

