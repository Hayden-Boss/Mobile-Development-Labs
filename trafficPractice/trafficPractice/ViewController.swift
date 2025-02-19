//
//  ViewController.swift
//  trafficPractice
//
//  Created by Hayden Boss on 2/5/25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func textFieldPrimaryActionTriggered(_ sender: Any) {
        textField.resignFirstResponder()
    }
    
    @IBAction func didEndEditing(_ sender: Any) {
        self
            .performSegue(withIdentifier: "yellow", sender: textField)
    }
    
    @IBAction func myUnwind(segue: UIStoryboardSegue) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "yellow" {
            segue.destination.navigationItem.title = textField.text
        }
    }
    
}
