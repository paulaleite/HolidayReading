//
//  NewBookTVC.swift
//  HolidayReading
//
//  Created by Paula Leite on 09/07/19.
//  Copyright © 2019 Paula Torales Leite. All rights reserved.
//

import UIKit
import CoreData

class NewBookTVC: UITableViewController {

    @IBOutlet var bookImageView: UIImageView!
    
    @IBOutlet var bookNameTextField: UITextField!
    
    @IBOutlet var numberOfPagesTextField: UITextField!
    
    @IBOutlet var timeReadingLabelHours: UILabel!
    
    @IBOutlet var timeReadingLabelMinutes: UILabel!
    
    @IBOutlet var timeReadingLabelSecounds: UILabel!
    
    @IBOutlet var timeReadingPicker: UIPickerView!
    
    @IBOutlet var limitReadingLabel: UILabel!
    
    @IBOutlet var limitReadingPicker: UIDatePicker!
    
    @IBOutlet var timeOfReadingLabel: UILabel!
    
    @IBOutlet var timeOfReadingPicker: UIDatePicker!
    
    var areCellsExpanded = [false, false, false]
    
    var context: NSManagedObjectContext?
    
    var timeReadingPickerData: [[String]] = [[String]]()
    
    var hour: String = ""
    var minutes: String = ""
    var secound: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
        navigationItem.rightBarButtonItem = saveButton
        
        // Amount of Time Picker
        self.timeReadingPicker.delegate = self
        self.timeReadingPicker.dataSource = self
        timeReadingPickerData = [["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23"],
                                 ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23",
                                  "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47",
                                  "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59"],
                                 ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23",
                                  "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47",
                                  "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59"]]
       
        // Code #3 of CBL Document File (https://paper.dropbox.com/doc/CBL-Document-Paula--Ag8Oeg_7LmUEIWysuJgmYuXEAQ-zck3kpaQYAspQuFvAsOxk)
        // Date Picker
        limitReadingPicker?.datePickerMode = .date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        limitReadingLabel.text = dateFormatter.string(from: limitReadingPicker.date)
        limitReadingPicker?.addTarget(self, action: #selector(dateChanged(limitReadingPicker:)), for: .valueChanged)
        
        // Time Picker
        timeOfReadingPicker?.datePickerMode = .time
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .short
        timeOfReadingLabel.text = timeFormatter.string(from: timeOfReadingPicker.date)
        timeOfReadingPicker?.addTarget(self, action: #selector(timeChanged(timeOfReadingPicker:)), for: .valueChanged)
        
        // Way of closing the keyboard
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        tap.cancelsTouchesInView = false
        
        // Footer
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
    }
    
    // Code #4 of CBL Document File (https://paper.dropbox.com/doc/CBL-Document-Paula--Ag8Oeg_7LmUEIWysuJgmYuXEAQ-zck3kpaQYAspQuFvAsOxk)
    @objc func dateChanged(limitReadingPicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        limitReadingLabel.text = dateFormatter.string(from: limitReadingPicker.date)
    }
    
    // Code #5 of CBL Document File (https://paper.dropbox.com/doc/CBL-Document-Paula--Ag8Oeg_7LmUEIWysuJgmYuXEAQ-zck3kpaQYAspQuFvAsOxk)
    @objc func timeChanged(timeOfReadingPicker: UIDatePicker) {
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .short
        timeOfReadingLabel.text = timeFormatter.string(from: timeOfReadingPicker.date)
    }
    
    @objc func save() {
        
        guard let context = context else { return }
        guard let book = NSEntityDescription.insertNewObject(forEntityName: "Book", into: context) as? Book else { return }
        navigationController?.popViewController(animated: true)
        
        if bookNameTextField.text != nil {
            book.bookName = bookNameTextField.text
        }
        
        book.pagesRead = 0
        
        if numberOfPagesTextField.text!.count > 0 {
            guard let numOfPages = Float(numberOfPagesTextField.text!) else { return }
            book.numOfPages = Float(numOfPages)
        } else {
            return
        }
        
        // Code #7 of CBL Document File (https://paper.dropbox.com/doc/CBL-Document-Paula--Ag8Oeg_7LmUEIWysuJgmYuXEAQ-zck3kpaQYAspQuFvAsOxk)
        book.timeOfReading = timeOfReadingPicker.date as NSDate
        
        // Code #7 of CBL Document File (https://paper.dropbox.com/doc/CBL-Document-Paula--Ag8Oeg_7LmUEIWysuJgmYuXEAQ-zck3kpaQYAspQuFvAsOxk)
        book.limitDataOfReading = limitReadingPicker.date as NSDate
        //book.timeOfReading = timeOfReadingPicker.date.timeIntervalSince1970
        
        // Code #8 of CBL Document File (https://paper.dropbox.com/doc/CBL-Document-Paula--Ag8Oeg_7LmUEIWysuJgmYuXEAQ-zck3kpaQYAspQuFvAsOxk)
        let amountOfTime = limitReadingPicker.date.timeIntervalSince(Date())
        book.amountOfTimeLeft = amountOfTime
        
        guard let numOfHours = Int64(timeReadingPickerData[0][timeReadingPicker.selectedRow(inComponent: 0)]) else { return }
        book.amountOfReadingTimeHour = numOfHours
        
        guard let numOfMinutes = Int64(timeReadingPickerData[1][timeReadingPicker.selectedRow(inComponent: 1)]) else { return }
        book.amountOfReadingTimeMinute = numOfMinutes
        
        guard let numOfSecound = Int64(timeReadingPickerData[2][timeReadingPicker.selectedRow(inComponent: 2)]) else { return }
        book.amountOfReadingTimeSecound = numOfSecound
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        
    }
    

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section >= 1 {
            if areCellsExpanded[indexPath.section - 1] {
                areCellsExpanded[indexPath.section - 1] = false
            } else {
                for i in 0 ..< areCellsExpanded.count {
                    areCellsExpanded[i] = false
                }
                areCellsExpanded[indexPath.section - 1] = true
            }

            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 161
        } else {
            return areCellsExpanded[indexPath.section - 1] == true ? 212 : 44
        }
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    
    

}
