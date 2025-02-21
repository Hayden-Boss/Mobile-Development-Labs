//
//  ViewController.swift
//  TallyApp
//
//  Created by Hayden Boss on 2/21/25.
//

import UIKit

class ViewController: UIViewController {
    var currentCount = 0
    var multiple = 1
    var history: [Int] = []
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var multipleTextField: UITextField!
    @IBOutlet weak var numberLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let multipleValue = Int(textField.text ?? "1") {
            multiple = multipleValue
        }
    }
    @IBAction func addButtonPressed(_ sender: UIButton) {
       if let multipleValue = Int(multipleTextField.text ?? "1") {
           multiple = multipleValue
            
        }
        
        history.append(currentCount)
        currentCount += multiple
        numberLabel.text = String(currentCount)
    }
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        if !history.isEmpty {
            currentCount = history.removeLast()
            numberLabel.text = String(currentCount)
        }
    }
    

}

