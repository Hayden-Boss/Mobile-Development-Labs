//
//  ViewController.swift
//  AppEventCount
//
//  Created by Hayden Boss on 3/7/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var didFinishLaunchingLabel: UILabel!
    var didFinishLaunchingCount = 0
     
    @IBOutlet weak var configurationForConnectingLabel: UILabel!
    var configurationForConnectingCount = 0
    
    @IBOutlet weak var willConnectToLabel: UILabel!
    var willConnectToCount = 0
    
    @IBOutlet weak var didBecomeActiveLabel: UILabel!
    var didBecomeActiveCount = 0
    
    @IBOutlet weak var willResignActiveLabel: UILabel!
    var willResignActiveCount = 0
    
    @IBOutlet weak var willEnterForegroundLabel: UILabel!
    var willEnterForegroundCount = 0
    
    @IBOutlet weak var didEnterBackgroundLabel: UILabel!
    var didEnterBackgroundCount = 0
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
func updateView() {
    didFinishLaunchingLabel.text = "The App has launched \(appDelegate.launchCount) time(s)"
    configurationForConnectingLabel.text = "The App is configuring for connecting \(appDelegate.configurationForConnectingCount) time(s)"
    willConnectToLabel.text = "The App is about to connect to \(willConnectToCount) time(s)"
    didBecomeActiveLabel.text = "The App is now active \(didBecomeActiveCount) time(s)"
    willResignActiveLabel.text = "The App is about to resign active \(willResignActiveCount) time(s)"
    willEnterForegroundLabel.text = "The App is about to enter the foreground \(willEnterForegroundCount) time(s)"
    didEnterBackgroundLabel.text = "The App is about to enter the background \(didEnterBackgroundCount) time(s)"
    }

}

