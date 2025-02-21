//
//  ViewController.swift
//  TextValidationApp
//
//  Created by Hayden Boss on 2/21/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var responseLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func submitButtonPressed(_ sender: Any) {
        guard let passwordText = passwordTextField.text else {
            return
        }
        let customSet: CharacterSet = [",",".","!","@","#","$","%","^","&","*","(",")"]
                if passwordText.count < 8 {
                    responseLabel .text = ("Password must be at least 8 characters long.")
                } else if passwordText.rangeOfCharacter(from: customSet) == nil {
                    responseLabel.text = ("Password must contain at least one special character.")
        } else {
            responseLabel.text = ("Password is valid!")
        }
    }
    
}

