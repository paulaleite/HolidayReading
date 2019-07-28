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
    
    @IBOutlet weak var numOfPages: UILabel! {
        didSet {
            numOfPages.textColor = UIColor(red: 90/255, green: 90/255, blue: 90/255, alpha: 1)
        }
    }
    
    @IBOutlet weak var timeLeft: UILabel! {
        didSet {
            timeLeft.textColor = UIColor(red: 90/255, green: 90/255, blue: 90/255, alpha: 1)
        }
    }
    
    @IBOutlet weak var updatePagesReadButton: UIButton! {
        didSet {
            updatePagesReadButton.setBackgroundImage(#imageLiteral(resourceName: "updatePagesRead"), for: .normal)
        }
    }
    
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.clipsToBounds = false
            containerView.layer.cornerRadius = 8
            containerView.layer.shadowOpacity = 2
            containerView.layer.shadowRadius = 2
            containerView.layer.shadowColor = UIColor.lightGray.cgColor
            containerView.layer.shadowOffset = CGSize(width: 2, height: 2)
    
        }
    }
    
    
    @IBOutlet weak var bookImage: RoundedImageView!
    
    @IBOutlet weak var selectedView: UIView! {
        didSet {
            selectedView.clipsToBounds = false
            selectedView.layer.cornerRadius = 8
            selectedView.layer.shadowOpacity = 6
            selectedView.layer.shadowRadius = 4
            selectedView.layer.shadowColor = UIColor.lightGray.cgColor
            selectedView.layer.shadowOffset = CGSize.zero
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
        changeSelectedViewColor(hasToChange: selected)
        
        if selected {
            UIView.animate(withDuration: 0.25) {
                self.setSelected(false, animated: true)
            }
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        changeSelectedViewColor(hasToChange: highlighted)
    }
    
    func changeSelectedViewColor(hasToChange: Bool) {
        if hasToChange {
            selectedView.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.35)
        } else {
            selectedView.layer.backgroundColor = UIColor.clear.cgColor
        }
    }

}
