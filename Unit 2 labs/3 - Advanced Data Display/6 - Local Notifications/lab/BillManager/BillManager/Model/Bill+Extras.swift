//
//  Bill+Extras.swift
//  BillManager
//

import Foundation
import UserNotifications

extension Bill {
    var hasReminder: Bool {
        return (remindDate != nil)
    }
    
    var isPaid: Bool {
        return (paidDate != nil)
    }
    
    var formattedDueDate: String {
        let dateString: String
        
        if let dueDate = self.dueDate {
            dateString = dueDate.formatted(date: .numeric, time: .omitted)
        } else {
            dateString = ""
        }
        
        return dateString
    }
    mutating func scheduleReminder(for date: Date, completion: @escaping (Bill) -> Void) {
            // Step 1: Remove any previously scheduled reminders
            removeReminder()

            // Step 2: Create a copy of self
            var updatedBill = self

            // Step 3: Check for notification permissions
            UNUserNotificationCenter.current().getNotificationSettings { settings in
                guard settings.authorizationStatus == .authorized else {
                    // Not authorized – return the bill unchanged
                    completion(updatedBill)
                    return
                }

                // Step 4: Create notification content
                let content = UNMutableNotificationContent()
                content.title = "Bill reminder"
                content.body = "You owe \(updatedBill.amount) to \(updatedBill.payee) by \(updatedBill.dueDate?.formatted(date: .abbreviated, time: .omitted))."
                content.sound = .default
                content.categoryIdentifier = Bill.notificationCategoryID

                // Step 5: Create a calendar-based trigger
                let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
                let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)

                // Step 6: Create a new notification ID
                let id = UUID().uuidString
                updatedBill.notificationID = id
                updatedBill.remindDate = date

                // Step 7: Create and add the notification request
                let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request) { _ in
                    completion(updatedBill)
                }
            }
    }

    mutating func removeReminder() {
        guard let notificationID = notificationID else { return }

        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [notificationID])

        self.notificationID = nil
        self.remindDate = nil
    }

}
