//
//  CalculatorButton.swift
//  Calculator
//
//  Created by Lisa Lin on 6/11/16.
//  Copyright © 2016 Jeffrey Lin. All rights reserved.
//

import UIKit

class CalculatorButton: UIButton {
    override func drawRect(rect: CGRect) {
        self.layer.borderWidth = 0.25
        self.layer.borderColor = UIColor.blackColor().CGColor
    }
}
