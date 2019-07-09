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
    
    @IBOutlet weak var bookImageView: UIImageView!
    
    @IBOutlet weak var nameOfBookLabel: UILabel!
    
    @IBOutlet weak var nameOfBookTextField: UITextField!
    
    @IBOutlet weak var pagesLabel: UILabel!
    
    @IBOutlet weak var pagesTextField: UILabel!
    
    @IBOutlet weak var amountOfPagesPerDayLabel: UILabel!
    
    @IBOutlet weak var amountOfPagesPerDayStepper: UIStepper!
    
    @IBOutlet weak var amountOfPagesPerDayView: UIView!
    
    @IBOutlet weak var amountOfPagesPerDayInputCell: UITableViewCell!
    
    @IBOutlet weak var amountOfPagesPerDayButton: UIButton!
    
    @IBOutlet weak var amountOfReadingPerDayLabel: UILabel!
    
    @IBOutlet weak var amountOfReadingPerDayTextField: UILabel!
    
    @IBOutlet weak var amountOfReadingPerDayPicker: UIPickerView!
    
    @IBOutlet weak var amountOfReadinPerDayInputCell: UITableViewCell!

    @IBOutlet weak var amountOfReadingPerDayButton: UIButton!
    
    @IBOutlet weak var timeOfReadingLabel: UILabel!
    
    @IBOutlet weak var timeOfReadingTextField: UILabel!
    
    @IBOutlet weak var timeOfReadingPicker: UIPickerView!
    
    @IBOutlet weak var timeOfReadingInputCell: UITableViewCell!
    
    @IBOutlet weak var timeOfReadingButton: UIButton!
    
    @IBOutlet weak var limitForReadingLabel: UILabel!
    
    @IBOutlet weak var limitForReadingTextField: UILabel!
    
    @IBOutlet weak var limitForReadingPicker: UIDatePicker!
    
    @IBOutlet weak var limitForReadingInputCell: UITableViewCell!
    
    @IBOutlet weak var limitForReadingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        amountOfPagesPerDayButton.addTarget(self, action: #selector(expandCloseCell), for: .touchUpInside)
        amountOfPagesPerDayButton.tag = selectedRow
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedRow = indexPath.row
        
//        if selectedRow == 2 {
//            amountOfPagesPerDayInputCell.isHidden.toggle()
//            self.tableView.moveRow(at: IndexPath(row: 4, section: 0), to: IndexPath(row: 3, section: 0))
//            self.tableView.moveRow(at: IndexPath(row: 5, section: 0), to: IndexPath(row: 4, section: 0))
//            self.tableView.moveRow(at: IndexPath(row: 6, section: 0), to: IndexPath(row: 5, section: 0))
//            self.tableView.moveRow(at: IndexPath(row: 7, section: 0), to: IndexPath(row: 6, section: 0))
//            self.tableView.moveRow(at: IndexPath(row: 8, section: 0), to: IndexPath(row: 7, section: 0))
//            self.tableView.moveRow(at: IndexPath(row: 9, section: 0), to: IndexPath(row: 8, section: 0))
//
//        }
    }
    
    @objc func expandCloseCell() {
        print("Testing button pressed")
    }

}
