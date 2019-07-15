//
//  RoundedImageView.swift
//  HolidayReading
//
//  Created by Paula Leite on 14/07/19.
//  Copyright © 2019 Paula Torales Leite. All rights reserved.
//

import UIKit

extension UITextField {
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.tintColor = #colorLiteral(red: 0.324716419, green: 0.313922286, blue: 0.6077176929, alpha: 1)
    }
}

extension UIButton {
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.titleLabel?.font = UIFont(name: "SF-Pro-Display-Regular", size: UIFont.buttonFontSize) ?? self.titleLabel?.font
    }
}

class RoundedImageView: UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
        
        self.layer.cornerRadius = 8

    }

}
