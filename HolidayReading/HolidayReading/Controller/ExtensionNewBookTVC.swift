//
//  ExtensionNewBookTVC.swift
//  HolidayReading
//
//  Created by Paula Leite on 15/07/19.
//  Copyright © 2019 Paula Torales Leite. All rights reserved.
//


// Code #2 of CBL Document File (https://paper.dropbox.com/doc/CBL-Document-Paula--Ag8Oeg_7LmUEIWysuJgmYuXEAQ-zck3kpaQYAspQuFvAsOxk)

import UIKit

extension NewBookTVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
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
        
        if component == 0 {
            hour = timeReadingPickerData[component][row]
            timeReadingLabelHours.text = "\(row)h, "
        } else if component == 1 {
            minutes = timeReadingPickerData[component][row]
            timeReadingLabelMinutes.text = "\(row)m, "
        } else if component == 2 {
            secound = timeReadingPickerData[component][row]
            timeReadingLabelSecounds.text = "\(row)s"
        }
        
        
    }
    
}
