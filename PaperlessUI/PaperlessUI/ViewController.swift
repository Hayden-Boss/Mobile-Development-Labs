//
//  ViewController.swift
//  PaperlessUI
//
//  Created by Hayden Boss on 1/23/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var flashlightButton: UIButton!
    var isFlashlightOn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonTapped(_ sender: Any) {
        if isFlashlightOn {
                view.backgroundColor = .black
            flashlightButton.tintColor = .yellow
                isFlashlightOn = false
        } else {
            view.backgroundColor = .white
            flashlightButton.tintColor = .blue
            isFlashlightOn = true
        }
    }
}

