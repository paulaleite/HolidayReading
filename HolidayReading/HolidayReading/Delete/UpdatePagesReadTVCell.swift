//
//  UpdatePagesReadTVCell.swift
//  HolidayReading
//
//  Created by Paula Leite on 01/08/19.
//  Copyright © 2019 Paula Torales Leite. All rights reserved.
//

import UIKit

class UpdatePagesReadTVCell: UITableViewCell {

    
    @IBOutlet var updatePagesReadButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        self.updatePagesReadButton.layer.cornerRadius = 10
        self.updatePagesReadButton.layer.backgroundColor = #colorLiteral(red: 0.8992445469, green: 0.7247573137, blue: 0.2885752916, alpha: 1)
        self.updatePagesReadButton.setTitle("Eu Li Hoje!", for: .normal)
        self.updatePagesReadButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }

}
