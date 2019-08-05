//
//  CustomPickerTVCell.swift
//  HolidayReading
//
//  Created by Paula Leite on 01/08/19.
//  Copyright © 2019 Paula Torales Leite. All rights reserved.
//

import UIKit
import CoreData

class CustomPickerTVCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var amountOfTimeReadingLabel: UILabel!
    
    @IBOutlet var amountOfHoursLabel: UILabel!
    
    @IBOutlet var amountOfMinutesLabel: UILabel!
    
    @IBOutlet var amountOfSecoundsLabel: UILabel!
    
    @IBOutlet var amountOfTimeReadingPicker: UIPickerView!
    
    var amountOfTimeReadingPickerData: [[String]] = [[String]]()
    
    var hour: String = ""
    var minutes: String = ""
    var secound: String = ""
    
    var book: Book?
    
    var context: NSManagedObjectContext?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        self.amountOfTimeReadingPicker.delegate = self
        self.amountOfTimeReadingPicker.dataSource = self
        amountOfTimeReadingPickerData = [["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23"],
                                         ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23",
                                          "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47",
                                          "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59"],
                                         ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23",
                                          "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47",
                                          "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59"]]
    }
    
    // Code #2 of CBL Document File (https://paper.dropbox.com/doc/CBL-Document-Paula--Ag8Oeg_7LmUEIWysuJgmYuXEAQ-zck3kpaQYAspQuFvAsOxk)
    
    // Will determine the amount of columns in the picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 3
        
    }
    
    // Will determine the amount of rows in the picker
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return 24
        } else {
            return 60
        }
        
    }
    
    // Incorporates the data into the picker
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0 {
            return "\(row) horas"
        } else if component == 1 {
            return "\(row) min"
        } else {
            return "\(row) seg"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if component == 0 {
            hour = amountOfTimeReadingPickerData[component][row]
            amountOfHoursLabel.text = "\(row)h, "
        } else if component == 1 {
            minutes = amountOfTimeReadingPickerData[component][row]
            amountOfMinutesLabel.text = "\(row)m, "
        } else if component == 2 {
            secound = amountOfTimeReadingPickerData[component][row]
            amountOfSecoundsLabel.text = "\(row)s"
        }
        
        guard let numOfHours = Int64(amountOfTimeReadingPickerData[0][amountOfTimeReadingPicker.selectedRow(inComponent: 0)]) else { return }
        book?.amountOfReadingTimeHour = numOfHours
        
        guard let numOfMinutes = Int64(amountOfTimeReadingPickerData[1][amountOfTimeReadingPicker.selectedRow(inComponent: 1)]) else { return }
        book?.amountOfReadingTimeMinute = numOfMinutes
        
        guard let numOfSecound = Int64(amountOfTimeReadingPickerData[2][amountOfTimeReadingPicker.selectedRow(inComponent: 2)]) else { return }
        book?.amountOfReadingTimeSecound = numOfSecound
        
        guard let bookID = book?.bookID else { return }
        cancelNotification(forId: bookID)
        
        
    }

}
