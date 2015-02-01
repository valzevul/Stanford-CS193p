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
    @IBOutlet weak var historyLabel: UILabel!
    
    var userIsInTheMiddleOfTypingANumber: Bool = false
    
    var brain = CalculatorBrain()
    
    @IBAction func clear(sender: UIButton) {
        userIsInTheMiddleOfTypingANumber = false
        displayValue = 0
        operandStack.removeAll(keepCapacity: false)
        brain = CalculatorBrain()
    }
    
    @IBAction func deleteLast(sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber {
            displayLabel.text = dropLast(displayLabel.text!)
            historyLabel.text = historyLabel.text! + " ←"
        }
    }
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            displayLabel.text = displayLabel.text! + digit
            historyLabel.text = historyLabel.text! + digit
        } else {
            displayLabel.text = digit
            userIsInTheMiddleOfTypingANumber = true
            historyLabel.text = historyLabel.text! + " " + digit
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = nil
            }
            
            historyLabel.text = historyLabel.text! + " " + operation
        }
    }

    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        // historyLabel.text = historyLabel.text! + "⏎"
        
        userIsInTheMiddleOfTypingANumber = false
        if let dValue = displayValue {
            if let result = brain.pushOperand(dValue) {
                displayValue = result
            } else {
                displayValue = nil
            }
        }
    }
    
    var displayValue: Double? {
        get {
            return NSNumberFormatter().numberFromString(displayLabel.text!)!.doubleValue
        }
        set {
            if let nV = newValue {
                displayLabel.text = "\(nV)"
            } else {
                displayLabel.text = "nil"
            }
            userIsInTheMiddleOfTypingANumber = false
        }
    }
    
}

