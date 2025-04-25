//
//  ViewController.swift
//  Contest
//
//  Created by Hayden Boss on 4/25/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        if ((emailTextField.text?.isEmpty) ?? true) {
            UIView.animate(withDuration: 0.01) {
                self.emailTextField.layer.borderColor = UIColor.red.cgColor
                self.emailTextField.layer.borderWidth = 1
            }
            let originalPosition = self.emailTextField.center
                    UIView.animate(withDuration: 0.05, animations: {
                        self.emailTextField.center = CGPoint(x: originalPosition.x - 5, y: originalPosition.y)
                    }) { _ in
                        UIView.animate(withDuration: 0.05, animations: {
                            self.emailTextField.center = CGPoint(x: originalPosition.x + 5, y: originalPosition.y)
                        }) { _ in
                            UIView.animate(withDuration: 0.05, animations: {
                                self.emailTextField.center = originalPosition
                            })
                        }
                    }
        } else {
            performSegue(withIdentifier: "emailEntered", sender: self)
            UIView.animate(withDuration: 0.0) {
                self.emailTextField.layer.borderColor = UIColor.gray.cgColor
                self.emailTextField.layer.borderWidth = 0
            }
        }
    }
    
}

