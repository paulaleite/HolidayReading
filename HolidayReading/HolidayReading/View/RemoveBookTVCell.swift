//
//  RemoveBookTVCell.swift
//  HolidayReading
//
//  Created by Paula Leite on 01/08/19.
//  Copyright © 2019 Paula Torales Leite. All rights reserved.
//

import UIKit

class RemoveBookTVCell: UITableViewCell {

    
    @IBOutlet var removeBookButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        self.removeBookButton.layer.borderWidth = 2
        self.removeBookButton.layer.borderColor = #colorLiteral(red: 0.7961079478, green: 0.3541672826, blue: 0.3972176015, alpha: 1)
        self.removeBookButton.layer.cornerRadius = 10
        self.removeBookButton.tintColor = #colorLiteral(red: 0.7976968884, green: 0.354347229, blue: 0.3951124549, alpha: 1)
        self.removeBookButton.setTitle("Excluir", for: .normal)
    }

}
