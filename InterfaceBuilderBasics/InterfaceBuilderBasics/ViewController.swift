//
//  ViewController.swift
//  InterfaceBuilderBasics
//
//  Created by Hayden Boss on 2/7/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func changeTitle(_ sender: Any) {
        nameLabel.text = "This app rocks!"
    }
    
}

