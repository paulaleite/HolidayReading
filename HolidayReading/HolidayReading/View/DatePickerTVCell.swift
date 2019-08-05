//
//  DatePickerTVCell.swift
//  HolidayReading
//
//  Created by Paula Leite on 02/08/19.
//  Copyright © 2019 Paula Torales Leite. All rights reserved.
//

import UIKit
import CoreData

class DatePickerTVCell: UITableViewCell {
    
    @IBOutlet var datePicker: UIDatePicker!
    
    @IBOutlet var dateInfoLabel: UILabel!
    
    @IBOutlet var dateTextLabel: UILabel!
    
    var book: Book?
    
    var context: NSManagedObjectContext?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        book?.limitDataOfReading = datePicker.date as NSDate
        
        let amountOfTime = datePicker.date.timeIntervalSince(Date())
        book?.amountOfTimeLeft = amountOfTime
        
        guard let bookID = book?.bookID else { return }
        cancelNotification(forId: bookID)
        
    }
    
    // Code #4 of CBL Document File (https://paper.dropbox.com/doc/CBL-Document-Paula--Ag8Oeg_7LmUEIWysuJgmYuXEAQ-zck3kpaQYAspQuFvAsOxk)
    @objc func dateChanged(limitOfReadingPicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        dateInfoLabel.text = dateFormatter.string(from: datePicker.date)
    }

}
