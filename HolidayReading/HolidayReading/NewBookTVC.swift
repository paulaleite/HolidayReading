//
//  NewBookTVC.swift
//  HolidayReading
//
//  Created by Paula Leite on 09/07/19.
//  Copyright © 2019 Paula Torales Leite. All rights reserved.
//

import UIKit

class NewBookTVC: UITableViewController {

    @IBOutlet var bookImageView: UIImageView!
    
    @IBOutlet var bookNameTextField: UITextField!
    
    @IBOutlet var numberOfPagesTextField: UITextField!
    
    @IBOutlet var timeReadingLabel: UILabel!
    
    @IBOutlet var timeReadingPicker: UIPickerView!
    
    @IBOutlet var limitReadingLabel: UILabel!
    
    @IBOutlet var limitReadingPicker: UIPickerView!
    
    @IBOutlet var timeOfReadingLabel: UILabel!
    
    @IBOutlet var timeOfReadingPicker: UIPickerView!
    
    var areCellsExpanded = [false, false, false]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section > 1 {
            if areCellsExpanded[indexPath.section - 2] {
                areCellsExpanded[indexPath.section - 2] = false
            } else {
                for i in 0 ..< areCellsExpanded.count {
                    areCellsExpanded[i] = false
                }
                areCellsExpanded[indexPath.section - 2] = true
            }

            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 160
        } else if indexPath.section == 1 {
            return 44
        } else {
            return areCellsExpanded[indexPath.section - 2] == true ? 212 : 44
        }
    }
    

}
