//
//  ViewController.swift
//  Alarm
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var datePicker: UIDatePicker!
    
    @IBOutlet var alarmLabel: UILabel!
    
    @IBOutlet var scheduleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI), name: .alarmUpdated, object: nil)
    }
    
    func presentNeedAuthorizationAlert() {
        let title = "Authorization needed"
        let message = "Alarms don't work without notifications, and it looks like you haven't granted us permission to send you those. Please go to the IOS Settings app and grant us notification permissions."
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func setAlarmButtonTapped(_ sender: UIButton) {
        if let alarm = Alarm.scheduled {
            alarm.unschedule()
        } else {
            let alarm = Alarm(date: datePicker.date)
            alarm.schedule { [weak self] (permissionGranted) in
                if !permissionGranted {
                    self?.presentNeedAuthorizationAlert()
                }
            }
        }
    }
    
    @objc func updateUI() {
        if let scheduledAlarm = Alarm.scheduled {
            let formattedAlarm = scheduledAlarm.date.formatted(.dateTime
                .day(.defaultDigits)
                .month(.defaultDigits)
                .year(.twoDigits)
                .hour().minute())
            alarmLabel.text = "Alarm set for: \(formattedAlarm)"
            datePicker.isEnabled = false
            scheduleButton.setTitle("Set Alarm", for: .normal)
        }
    }
}

