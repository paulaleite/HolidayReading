//
//  DatePickerTVCell.swift
//  HolidayReading
//
//  Created by Paula Leite on 01/08/19.
//  Copyright © 2019 Paula Torales Leite. All rights reserved.
//

import UIKit
import CoreData

class TimeDatePickerTVCell: UITableViewCell {

    @IBOutlet var timeDatePicker: UIDatePicker!
    
    @IBOutlet var timeInfoLabel: UILabel!
    
    @IBOutlet var timeTextLabel: UILabel!
    
    var book: Book?
    
    var context: NSManagedObjectContext?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        book?.timeOfReading = timeDatePicker.date as NSDate
        
        guard let bookID = book?.bookID else { return }
        cancelNotification(forId: bookID, category: 0)
        cancelNotification(forId: bookID, category: 1)
        
        
    }
    
    // Code #5 of CBL Document File (https://paper.dropbox.com/doc/CBL-Document-Paula--Ag8Oeg_7LmUEIWysuJgmYuXEAQ-zck3kpaQYAspQuFvAsOxk)
    @objc func timeChanged(timeOfReadingPicker: UIDatePicker) {
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .short
        
        timeInfoLabel.text = timeFormatter.string(from: timeDatePicker.date)
    }
    
    
    

}
