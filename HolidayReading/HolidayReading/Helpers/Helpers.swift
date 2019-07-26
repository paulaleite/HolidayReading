//
//  Helpers.swift
//  HolidayReading
//
//  Created by Paula Leite on 24/07/19.
//  Copyright © 2019 Paula Torales Leite. All rights reserved.
//

// Code #12 and #13 of CBL Document File (https://paper.dropbox.com/doc/CBL-Document-Paula--Ag8Oeg_7LmUEIWysuJgmYuXEAQ-zck3kpaQYAspQuFvAsOxk)

import UIKit
import UserNotifications

func scheduleNotification(for book: Book?, withTitle title: String, andBody body: String, categoria: Int) {
    guard let book = book as Book? else { return }
    let notificationCenter = UNUserNotificationCenter.current()
    
    let generalCategory = UNNotificationCategory(identifier: "generalCatID",
                                                 actions: [],
                                                 intentIdentifiers: [],
                                                 options: [.customDismissAction])
    
    notificationCenter.setNotificationCategories([generalCategory])
    
    notificationCenter.getNotificationSettings { (settings) in
        if settings.authorizationStatus == .authorized {
            
            let content = UNMutableNotificationContent()
            
            content.title = NSString.localizedUserNotificationString(forKey: title, arguments: nil)
            
            content.body = NSString.localizedUserNotificationString(forKey: body, arguments: nil)
            
            content.sound = UNNotificationSound.default
            content.badge = 1
            content.categoryIdentifier = "generalCatID"
            
            let date = book.timeOfReading
            
            let triggerDaily = Calendar.current.dateComponents([.hour, .minute, .second], from: date! as Date)
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: true)
            
            guard let bookID = book.bookID else { return }
            let request = UNNotificationRequest(identifier: "\(bookID)\(categoria)", content: content, trigger: trigger)
            
            notificationCenter.add(request) { (error : Error?) in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
            
        } else {
            print("Impossível mandar notificação - permissão negada")
        }
    }
}

func scheduleSecoundNotification(for book: Book?, andBody body: String, categoria: Int) {
    guard let book = book as Book? else { return }
    let notificationCenter = UNUserNotificationCenter.current()
    
    let generalCategory = UNNotificationCategory(identifier: "generalCatID2",
                                                 actions: [],
                                                 intentIdentifiers: [],
                                                 options: [.customDismissAction])
    
    notificationCenter.setNotificationCategories([generalCategory])
    
    notificationCenter.getNotificationSettings { (settings) in
        if settings.authorizationStatus == .authorized {
            
            let content = UNMutableNotificationContent()
            
            content.title = NSString.localizedUserNotificationString(forKey: "Anote o seu progresso", arguments: nil)
            
            content.body = NSString.localizedUserNotificationString(forKey: body, arguments: nil)
            
            content.sound = UNNotificationSound.default
            content.badge = 1
            content.categoryIdentifier = "generalCatID2"
            
            let date = book.timeOfReading
            
            let calendar = Calendar.autoupdatingCurrent
            guard let newDate = date as Date? else { return }
            var components = calendar.dateComponents([.hour, .minute, .second], from: newDate)
            guard let hour = components.hour else { return }
            components.hour = hour + Int(book.amountOfReadingTimeHour)
            guard let minute = components.minute else { return }
            components.minute = minute + Int(book.amountOfReadingTimeMinute)
            guard let second = components.second else { return }
            components.second = second + Int(book.amountOfReadingTimeSecound)
            
            let triggerDaily = Calendar.current.dateComponents([.hour, .minute, .second], from: newDate)
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: true)
            
            guard let bookID = book.bookID else { return }
            let request = UNNotificationRequest(identifier: "\(bookID)\(categoria)", content: content, trigger: trigger)
            
            notificationCenter.add(request) { (error : Error?) in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
            
        } else {
            print("Impossível mandar notificação - permissão negada")
        }
    }
}

func cancelNotification(forId id: String, categoria: Int) {
    let notificationCenter = UNUserNotificationCenter.current()
    notificationCenter.removePendingNotificationRequests(withIdentifiers: ["\(id)\(categoria)"])
}
