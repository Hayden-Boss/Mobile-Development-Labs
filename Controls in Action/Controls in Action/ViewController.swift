//
//  ViewController.swift
//  Controls in Action
//
//  Created by Hayden Boss on 1/28/25.
//

import UIKit

class ViewController: UIViewController {
    
    let colors: [UIColor] = [.red, .green, .blue, .yellow, .orange, .purple, .brown, .magenta]
    
    @IBOutlet weak var randomColorButton: UIButton!
    @IBOutlet weak var opacitySlider: UISlider!
    @IBOutlet weak var showControlsSwitch: UISwitch!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func randomColorButtonTapped(_ sender: Any) {
        let randomColor =
        colors.randomElement()
        
        self.view.backgroundColor = randomColor
    }
    
    @IBAction func opacitySliderValueChanged(_ sender: UISlider) {
        
        self.view.alpha = CGFloat(sender.value)
    }
    
    @IBAction func showControlsSwitchToggled(_ sender: UISwitch) {
        
        self.randomColorButton.isHidden = !sender.isOn
        self.opacitySlider.isHidden = !sender.isOn
    }

    @IBAction func textFieldSomthing(_ sender: UITextField) {
        self.textLabel.text = sender.text
        sender.text = ""
    }
    
    
}

