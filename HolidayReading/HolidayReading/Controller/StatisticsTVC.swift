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
    
    var books: [Book] = []
    //var book: Book?
    
    var stats: [Statistics] = []
    
    var stat: Statistics?
    
    var context: NSManagedObjectContext?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        do {
            guard let context = context else { return }
            books = try context.fetch(Book.fetchRequest())
            stats = try context.fetch(Statistics.fetchRequest())
            
            if stats.count == 0 {
                guard let stats = NSEntityDescription.insertNewObject(forEntityName: "Statistics", into: context) as? Statistics else { return }
                
                stats.booksRead = 0
                stats.pagesRead = 0
                stats.daysRead = 0
                stats.minutesRead = 0
                stats.lastDayRead = nil
                stats.pointsMade = 0
            } 
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if stats.count == 0 {
            do {
                guard let context = context else { return }
                stats = try context.fetch(Statistics.fetchRequest())
                
            } catch let error {
                print(error.localizedDescription)
            }
        }
        amountOfBooksReadLabel.text = "\(stats[0].booksRead)"
        amountOfPagesReadLabel.text = "\(stats[0].pagesRead)"
        amountOfDaysReadLabel.text = "\(stats[0].daysRead)"
        amountOfMinutesReadLabel.text = "\(stats[0].minutesRead)"
        amountOfPointsLabel.text = "\(stats[0].pointsMade)"
        
    }
    
    func calcTotalBooksRead(from books: [Book?]?) -> Int64 {
        var amountOfBooksRead: Int64 = 0
        
        guard let books = books else { return 0 }

        for object in books {
            guard let book = object as Book? else { return 0 }
            
            if book.pagesRead == book.numOfPages {
                amountOfBooksRead += 1
            }
            
        }
        
        return amountOfBooksRead
        
    }
    
    func calcTotalOfPagesRead(from books: [Book?]?) -> Int64 {
        var amountOfPagesRead: Int64 = 0

        guard let books = books else { return 0 }
        
        for object in books {
            guard let book = object as Book? else { return 0 }
            amountOfPagesRead += Int64(book.pagesRead)
        }
        
        return amountOfPagesRead
    }
    
    func calcTotalOfMinutesRead(from books: [Book?]?) -> Int64 {
        var amountOfMinutesRead: Int64 = 0
        
        guard let books = books else { return 0 }
        
        for object in books {
            guard let book = object as Book? else { return 0 }
            amountOfMinutesRead += book.timesRead * ((book.amountOfReadingTimeHour * 60) + book.amountOfReadingTimeMinute + (book.amountOfReadingTimeSecound / 60))
        }
        
        return amountOfMinutesRead
    }
    
    func calcTotalPoint(from stats: [Statistics?]?) -> Int64 {
        var amountOfPoints: Int64 = 0
        
        guard let stats = stats else { return 0 }
        
        for object in stats {
            guard let stat = object as Statistics? else { return 0 }
            amountOfPoints = (10 * stat.booksRead) + (5 * stat.daysRead)
        }
        
        return amountOfPoints
    }

}
