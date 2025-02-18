//
//  ViewController.swift
//  Login
//
//  Created by Hayden Boss on 2/18/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var forgotUserNameButton: UIButton!
    
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let sender = sender as? UIButton else { return }
        
        if sender == forgotPasswordButton {
            segue.destination.navigationItem.title = "Forgot Password"
        } else if sender == forgotUserNameButton {
            segue.destination.navigationItem.title = "Forgot Username"
        } else {
            segue.destination.navigationItem.title = usernameTextField.text
        }
    }
        
        @IBAction func forgotPasswordButtonTapped(_ sender: Any) {
            performSegue(withIdentifier: "ForgottenUsernameOrPassword", sender: sender)
        }
        @IBAction func forgotUserNameButtonTapped(_ sender: Any) {
            performSegue(withIdentifier: "ForgottenUsernameOrPassword", sender: sender)
        }
    }
    
