//
//  PointsTVCell.swift
//  HolidayReading
//
//  Created by Paula Leite on 06/07/19.
//  Copyright © 2019 Paula Torales Leite. All rights reserved.
//

import UIKit

class PointsTVCell: UITableViewCell {
    
    @IBOutlet weak var amountOfPoints: UILabel! // I need to adapt this number
    
    @IBOutlet weak var pointsLabel:UILabel!
    
    
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = 10
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
