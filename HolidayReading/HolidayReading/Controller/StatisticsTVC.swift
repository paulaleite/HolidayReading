//
//  StatisticsTVC.swift
//  HolidayReading
//
//  Created by Paula Leite on 18/07/19.
//  Copyright © 2019 Paula Torales Leite. All rights reserved.
//

import UIKit
import CoreData

class StatisticsTVC: UITableViewController {
    
    @IBOutlet var amountOfBooksReadLabel: UILabel!
    
    @IBOutlet var amountOfPagesReadLabel: UILabel!
    
    @IBOutlet var amountOfDaysReadLabel: UILabel!
    
    @IBOutlet var amountOfMinutesReadLabel: UILabel!
    
    @IBOutlet var amountOfPointsLabel: UILabel!
    
    var book: Book?
    var log: Log?

    override func viewDidLoad() {
        super.viewDidLoad()

//        if let book = book {
//            if let log = log {
//                if book.pagesRead == book.numOfPages {
//                    log.amountOfBooksReadCounter += 1
//                }
//                amountOfBooksReadLabel.text = "\(log.amountOfBooksReadCounter)"
//                
//                
//                
//                
//            }
//        }
        
    }

    

    

}
