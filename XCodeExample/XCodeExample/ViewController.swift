//
//  ViewController.swift
//  XCodeExample
//
//  Created by Hayden Boss on 1/22/25.
//

import UIKit

class ViewController: UIViewController {
    var name: String = "Bob"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        name = "Sally"
        print(name)
        let thing: String? = "Hello, world!"
        if let thing {
            print(thing)
        }
    }

}

