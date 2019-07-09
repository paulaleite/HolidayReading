//
//  MyBooksTVCell.swift
//  HolidayReading
//
//  Created by Paula Leite on 06/07/19.
//  Copyright © 2019 Paula Torales Leite. All rights reserved.
//

import UIKit

class MyBooksTVCell: UITableViewCell {

    @IBOutlet weak var bookTitle: UILabel! {
        didSet {
            bookTitle.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        }
    }
    
    @IBOutlet weak var numOfPagesLabel: UILabel! {
        didSet {
            numOfPagesLabel.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        }
    }
    
    @IBOutlet weak var numOfPages: UILabel! {
        didSet {
            numOfPages.textColor = UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1)
        }
    }
    
    @IBOutlet weak var timeLeftLabel: UILabel! {
        didSet {
            timeLeftLabel.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        }
    }
    
    @IBOutlet weak var timeLeft: UILabel! {
        didSet {
            timeLeft.textColor = UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1)
        }
    }
    
    @IBOutlet weak var checkmarkButton: UIButton! {
        didSet {
            checkmarkButton.layer.borderWidth = 2
            checkmarkButton.layer.borderColor = UIColor(red: 222/255, green: 172/255, blue: 58/255, alpha: 1).cgColor
            checkmarkButton.layer.cornerRadius = 0.5 * checkmarkButton.frame.width
        }
    }
    
    @IBOutlet weak var checkmarkImage: UIImageView!
    
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = 10
            containerView.layer.shadowOpacity = 6
            containerView.layer.shadowRadius = 4
            containerView.layer.shadowColor = UIColor.lightGray.cgColor
            containerView.layer.shadowOffset = CGSize(width: 3, height: 3)
        }
    }
    
    
    @IBOutlet weak var bookImage: UIImageView! {
        didSet {
            bookImage.layer.cornerRadius = 10
            bookImage.layer.shadowOpacity = 6
            bookImage.layer.shadowRadius = 4
            bookImage.layer.shadowColor = UIColor.lightGray.cgColor
            bookImage.layer.shadowOffset = CGSize(width: 3, height: 3)
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
