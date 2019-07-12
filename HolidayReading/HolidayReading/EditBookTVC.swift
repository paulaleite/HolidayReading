//
//  EditBookTVC.swift
//  HolidayReading
//
//  Created by Paula Leite on 12/07/19.
//  Copyright © 2019 Paula Torales Leite. All rights reserved.
//

import UIKit

class EditBookTVC: UITableViewController {
    
    @IBOutlet weak var pagesProgressView: UIProgressView!
    
    @IBOutlet weak var pagesLabel: UILabel!
    
    @IBOutlet var timeOfReadingPerDayLabel: UILabel!
    
    @IBOutlet var timeOfReadingPerDayPicker: UIPickerView!
    
    @IBOutlet var timeOfReadingLabel: UILabel!
    
    @IBOutlet var timeOfReadingPicker: UIPickerView!
    
    @IBOutlet var limitOfReadingLabel: UILabel!
    
    @IBOutlet var limitOfReadingPicker: UIPickerView!
    
    @IBOutlet var readingUpdateButton: UIButton!
    
    var areCellsExpanded = [false, false, false]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section >= 1 && indexPath.section < 4 {
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
        if indexPath.section == 0 || indexPath.section == 4 {
            return 44
        } else if indexPath.section == 5 {
            return 168
        } else {
            return areCellsExpanded[indexPath.section - 1] == true ? 212 : 44
        }
    }

}
