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
    
    var context: NSManagedObjectContext?
    
    let increments: Float = 1
    
    @IBOutlet var addButton: UIButton! {
        didSet {
            addButton.layer.cornerRadius = 10
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissVC))
        self.view.addGestureRecognizer(tap)
        tap.cancelsTouchesInView = false
        
        guard let numOfPages = book?.numOfPages else { return }
        guard let amountOfPages = book?.pagesRead else { return }
        amountOfPagesSlider.maximumValue = numOfPages - amountOfPages
        
        amountOfPagesSlider.minimumValue = 0
        
    }
    
    
    @objc func dismissVC() {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func associateAmountOfPages(_ sender: Any) {
        
        book?.pagesRead += amountOfPagesSlider.value
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        MainTVC?.updateBook()
        
        dismissVC()
        
        guard let test = (book?.lastDayThatRead?.isEqual(to: Date())) else { return }
        if book?.lastDayThatRead == nil {
            book?.lastDayThatRead = NSDate()
        } else if book?.lastDayThatRead != NSDate() {
            if !(test) {
                book?.timesRead += 1
            }
        }
        
        
        let currentCalendar = Calendar.autoupdatingCurrent
        let currentComponents = currentCalendar.dateComponents([.day, .month, .year], from: Date())
        let currentDay = currentComponents.day
        let currentMonth = currentComponents.month
        let currentYear = currentComponents.year
        
        guard let date = book?.lastDayThatRead! as Date? else { return }
        let calendar = Calendar.autoupdatingCurrent
        let components = calendar.dateComponents([.day, .month, .year], from: date)
        let day = components.day
        let month = components.month
        let year = components.year

        
        if day == nil && month == nil && year == nil {
            book?.lastDayThatRead = NSDate()
        } else if day != currentDay || month != currentMonth || year != currentYear {
            
            book?.lastDayThatRead = NSDate()
            book?.timesRead += 1
        }
        
    
        
        
    }
    
    // Code #10 of CBL Document File (https://paper.dropbox.com/doc/CBL-Document-Paula--Ag8Oeg_7LmUEIWysuJgmYuXEAQ-zck3kpaQYAspQuFvAsOxk)
    @IBAction func sliderValueChanged(_ sender: Any) {
        
        // Code #9 of CBL Document File (https://paper.dropbox.com/doc/CBL-Document-Paula--Ag8Oeg_7LmUEIWysuJgmYuXEAQ-zck3kpaQYAspQuFvAsOxk)
        let roundedValue = round(amountOfPagesSlider.value / increments) * increments
        amountOfPagesSlider.value = roundedValue
        
        amountOfPagesLabel.text = "\(Int(amountOfPagesSlider.value))"
    }
    
}
