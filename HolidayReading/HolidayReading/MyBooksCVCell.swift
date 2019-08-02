//
//  MyBooksCVCell.swift
//  HolidayReading
//
//  Created by Paula Leite on 01/08/19.
//  Copyright © 2019 Paula Torales Leite. All rights reserved.
//

import UIKit

class MyBookCVCell: UICollectionViewCell {
    
    @IBOutlet var daysLabel: UILabel!
    @IBOutlet var daysLeftLabel: UILabel!
    
    @IBOutlet var pagesLabel: UILabel!
    @IBOutlet var pagesLeftLabel: UILabel!
    
    @IBOutlet var bookNameLabel: UILabel!
    
    @IBOutlet var bookImage: UIImageView! {
        didSet {
            let rectShape = CAShapeLayer()
            rectShape.bounds = self.bookImage.frame
            rectShape.position = self.bookImage.center
            rectShape.path = UIBezierPath(roundedRect: self.bookImage.bounds.offsetBy(dx: 0, dy: 20).insetBy(dx: 0, dy: -20), byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 8, height: 8)).cgPath
            
            self.bookImage.layer.mask = rectShape
        }
    }
 
    
    @IBOutlet var updatePagesRead: UIButton! {
        didSet {
            updatePagesRead.layer.cornerRadius = updatePagesRead.frame.width/2
            updatePagesRead.clipsToBounds = false
            self.updatePagesRead.layer.borderWidth = 1
            self.updatePagesRead.layer.borderColor = #colorLiteral(red: 0.8705882353, green: 0.6745098039, blue: 0.2274509804, alpha: 1)
            //updatePagesRead.layer.shadowOpacity = 6
            //updatePagesRead.layer.shadowRadius = 4
            //updatePagesRead.layer.shadowColor = UIColor.lightGray.cgColor
            //updatePagesRead.layer.shadowOffset = CGSize.zero
        }
    }
    
    @IBOutlet var cellView: UIView! {
        didSet {
            cellView.layer.cornerRadius = 8
            cellView.clipsToBounds = false
            cellView.layer.shadowOpacity = 6
            cellView.layer.shadowRadius = 4
            cellView.layer.shadowColor = UIColor.lightGray.cgColor
            cellView.layer.shadowOffset = CGSize.zero
        }
    }
    
    
    
}
