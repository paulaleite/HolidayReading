//
//  UpdatePagesReadVC.swift
//  HolidayReading
//
//  Created by Paula Leite on 14/07/19.
//  Copyright © 2019 Paula Torales Leite. All rights reserved.
//

import UIKit
import CoreData

class UpdatePagesReadVC: UIViewController {

    var book: Book?
    
    var MainTVC: MyBooksTVC?
    
    @IBOutlet var amountOfPagesSlider: UISlider!
    
    @IBOutlet var amountOfPagesLabel: UILabel!
    
    @IBOutlet var bgView: UIView!
    
    var context: NSManagedObjectContext?
    
    let increments: Float = 1
    
    var stats: [Statistics] = []
    
    @IBOutlet var addButton: UIButton! {
        didSet {
            addButton.layer.cornerRadius = 10
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissVC))
        bgView.addGestureRecognizer(tap)
        tap.cancelsTouchesInView = true
        
        guard let numOfPages = book?.numOfPages else { return }
        guard let amountOfPages = book?.pagesRead else { return }
        amountOfPagesSlider.maximumValue = numOfPages - amountOfPages
        
        amountOfPagesSlider.minimumValue = 0
        
        do {
            guard let context = context else { return }
            stats = try context.fetch(Statistics.fetchRequest())

        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    
    
    @objc func dismissVC() {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func associateAmountOfPages(_ sender: Any) {
        
        book?.pagesRead += amountOfPagesSlider.value
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        MainTVC?.updateBook()
        
        dismissVC()
        
        // Amount of days reading
        let currentCalendar = Calendar.autoupdatingCurrent
        let currentComponents = currentCalendar.dateComponents([.day, .month, .year], from: Date())
        let currentDay = currentComponents.day
        let currentMonth = currentComponents.month
        let currentYear = currentComponents.year
        
        if stats[0].lastDayRead != nil {
            guard let date = stats[0].lastDayRead as Date? else { return }
            let calendar = Calendar.autoupdatingCurrent
            let components = calendar.dateComponents([.day, .month, .year], from: date)
            let day = components.day
            let month = components.month
            let year = components.year

            
            if day != currentDay || month != currentMonth || year != currentYear {
                stats[0].lastDayRead = NSDate()
                stats[0].daysRead += 1
                book?.timesRead += 1
            }
        } else {
            stats[0].lastDayRead = NSDate()
            stats[0].daysRead += 1
            book?.timesRead += 1
        }
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        // Putting this info in the statistics TVC
        
        
    }
    
    // Code #10 of CBL Document File (https://paper.dropbox.com/doc/CBL-Document-Paula--Ag8Oeg_7LmUEIWysuJgmYuXEAQ-zck3kpaQYAspQuFvAsOxk)
    @IBAction func sliderValueChanged(_ sender: Any) {
        
        // Code #9 of CBL Document File (https://paper.dropbox.com/doc/CBL-Document-Paula--Ag8Oeg_7LmUEIWysuJgmYuXEAQ-zck3kpaQYAspQuFvAsOxk)
        let roundedValue = round(amountOfPagesSlider.value / increments) * increments
        amountOfPagesSlider.value = roundedValue
        
        amountOfPagesLabel.text = "\(Int(amountOfPagesSlider.value))"
    }
    
}
