//
//  DatePickerTVCell.swift
//  HolidayReading
//
//  Created by Paula Leite on 01/08/19.
//  Copyright © 2019 Paula Torales Leite. All rights reserved.
//

import UIKit

class DatePickerTVCell: UITableViewCell {

    @IBOutlet var datePicker: UIDatePicker!
    
    @IBOutlet var infoLabel: UILabel!
    
    @IBOutlet var textInfoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }

}
