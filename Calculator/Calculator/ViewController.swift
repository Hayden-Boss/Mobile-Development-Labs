//
//  ViewController.swift
//  Calculator
//
//  Created by Hayden Boss on 2/12/25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var displayLabel: UILabel!
    
    var currentNumber: String = ""
    var previousNumber: String = ""
    var operation: String?
    var fullEquation: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayLabel.text = "0"
    }

    @IBAction func numberPressed(_ sender: UIButton) {
        if let numberText = sender.titleLabel?.text {
            if numberText == "." {
                if currentNumber.contains(".") {
                    return
                }
                if currentNumber.isEmpty {
                    currentNumber = "0"
                    fullEquation += "0"
                }
            }
            
            currentNumber += numberText
            fullEquation += numberText
            displayLabel.text = fullEquation
        }
    }


    @IBAction func operationPressed(_ sender: UIButton) {
        if let operationSymbol = sender.titleLabel?.text {
            if !currentNumber.isEmpty {
                previousNumber = currentNumber
                currentNumber = ""
            }
            operation = operationSymbol
            fullEquation += " \(operationSymbol) "
            displayLabel.text = fullEquation
        }
    }

    @IBAction func equalsPressed(_ sender: UIButton) {
        let expression = NSExpression(format: fullEquation.replacingOccurrences(of: "x", with: "*").replacingOccurrences(of: "÷", with: "/"))
        if let result = expression.expressionValue(with: nil, context: nil) as? Double {
            displayLabel.text = "\(fullEquation) = \(result)"
            fullEquation = "\(result)"
        }
    }

    @IBAction func clearPressed(_ sender: UIButton) {
        currentNumber = ""
        previousNumber = ""
        operation = nil
        fullEquation = ""
        displayLabel.text = "0"
    }
}
