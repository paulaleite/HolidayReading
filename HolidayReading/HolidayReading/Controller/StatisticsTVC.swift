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
                
                stats.booksRead = calcTotalBooksRead(from: books)
                stats.pagesRead = calcTotalOfPagesRead(from: books)
                stats.daysRead = 0
                stats.minutesRead = calcTotalOfMinutesRead(from: books)
                stats.lastDayRead = nil
                stats.pointsMade = (10 * stats.booksRead) + (5 * stats.daysRead)
            } else {
                stats[0].booksRead = calcTotalBooksRead(from: books)
                stats[0].pagesRead = calcTotalOfPagesRead(from: books)
                stats[0].minutesRead = calcTotalOfMinutesRead(from: books)
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
            // preciso saber quantas vezes o usuario inseriu uma quantidade de paginas multiplicado pelo tempo de leitura que o usuário disponibilizou
            amountOfMinutesRead += book.timesRead * ((book.amountOfReadingTimeHour*60) + book.amountOfReadingTimeMinute + (book.amountOfReadingTimeSecound/60))
        }
        
        return amountOfMinutesRead
    }

    

    

}
