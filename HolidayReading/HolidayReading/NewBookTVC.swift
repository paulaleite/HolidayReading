//
//  NewBookTVC.swift
//  HolidayReading
//
//  Created by Paula Leite on 09/07/19.
//  Copyright © 2019 Paula Torales Leite. All rights reserved.
//

import UIKit

class NewBookTVC: UITableViewController {

    var selectedRow: Int = 0
    
    var selectedSection: Int = 2
    
    var selected: Bool = false
    
    @IBOutlet weak var bookImageView: UIImageView!
    
    @IBOutlet weak var nameOfBookLabel: UILabel!
    
    @IBOutlet weak var nameOfBookTextField: UITextField!
    
    @IBOutlet weak var pagesLabel: UILabel!
    
    @IBOutlet weak var pagesTextField: UILabel!
    
    @IBOutlet weak var amountOfPagesPerDayLabel: UILabel!
    
    @IBOutlet weak var amountOfPagesPerDayStepper: UIStepper!
    
    @IBOutlet weak var amountOfPagesPerDayView: UIView!
    
    @IBOutlet weak var amountOfPagesPerDayInputCell: UITableViewCell!
    
    @IBOutlet weak var amountOfReadingPerDayLabel: UILabel!
    
    @IBOutlet weak var amountOfReadingPerDayTextField: UILabel!
    
    @IBOutlet weak var amountOfReadingPerDayPicker: UIPickerView!
    
    @IBOutlet weak var amountOfReadinPerDayInputCell: UITableViewCell!
    
    @IBOutlet weak var timeOfReadingLabel: UILabel!
    
    @IBOutlet weak var timeOfReadingTextField: UILabel!
    
    @IBOutlet weak var timeOfReadingPicker: UIPickerView!
    
    @IBOutlet weak var timeOfReadingInputCell: UITableViewCell!
    
    @IBOutlet weak var limitForReadingLabel: UILabel!
    
    @IBOutlet weak var limitForReadingTextField: UILabel!
    
    @IBOutlet weak var limitForReadingPicker: UIDatePicker!
    
    @IBOutlet weak var limitForReadingInputCell: UITableViewCell!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        amountOfPagesPerDayInputCell.isHidden = true
    }
    

}
