//
//  MiddleViewController.swift
//  OrderOfEvents
//
//  Created by Hayden Boss on 2/18/25.
//

import UIKit

class MiddleViewController: UIViewController {

    @IBOutlet var middleViewControllerLabel: UILabel!
    var eventNumber: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    func addEvent(from:String) {
        if let existingText = middleViewControllerLabel.text {
            middleViewControllerLabel.text = "\(existingText)\nEvent \(eventNumber) was \(from)"
            eventNumber += 1
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
