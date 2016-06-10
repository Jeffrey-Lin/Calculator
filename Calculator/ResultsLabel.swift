//
//  ResultsLabelViewController.swift
//  Calculator
//
//  Created by Lisa Lin on 5/27/16.
//  Copyright © 2016 Jeffrey Lin. All rights reserved.
//

import UIKit

class ResultsLabel: UILabel {
    override func drawTextInRect(rect: CGRect) {
        let insets = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 20)
        super.drawTextInRect(UIEdgeInsetsInsetRect(rect, insets))
    }
}
