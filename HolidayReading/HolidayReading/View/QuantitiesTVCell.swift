//
//  QuantitiesTVCell.swift
//  HolidayReading
//
//  Created by Paula Leite on 06/07/19.
//  Copyright © 2019 Paula Torales Leite. All rights reserved.
//

import UIKit

class QuantitiesTVCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.textColor = UIColor(red: 244/255, green: 244/255, blue: 255/255, alpha: 1)
        }
    }
    
    @IBOutlet weak var quantityLabel: UILabel! {
        didSet {
            quantityLabel.textColor = UIColor(red: 244/255, green: 244/255, blue: 255/255, alpha: 1)
        }
    } // I need to adapt this whenever they get more "points"
    
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = 10
            containerView.backgroundColor = UIColor(red: 65/255, green: 59/255, blue: 137/255, alpha: 0.6)
            containerView.clipsToBounds = false
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
