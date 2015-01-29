//
//  ViewController.swift
//  Calculator
//
//  Created by Vadim Drobinin on 29/1/15.
//  Copyright (c) 2015 Vadim Drobinin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    
    var userIsInTheMiddleOfTypingANumber: Bool = false
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            displayLabel.text = displayLabel.text! + digit
        } else {
            displayLabel.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
        
    }
}

