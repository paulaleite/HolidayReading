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
    
    var points: Points?
    
    var context: NSManagedObjectContext?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            guard let context = context else { return }
            books = try context.fetch(Book.fetchRequest())
            
            //print(books.count)
            
            tableView.reloadData()
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        amountOfBooksReadLabel.text = "\(calcTotalBooksRead(from: books))"
        amountOfPagesReadLabel.text = "\(calcTotalOfPagesRead(from: books))"
        amountOfDaysReadLabel.text = "\(calcTotalOfDaysRead(from: books))"
        amountOfMinutesReadLabel.text = "\(calcTotalOfMinutesRead(from: books))"
        
        guard let context = context else { return }
        guard let stats = NSEntityDescription.insertNewObject(forEntityName: "Points", into: context) as? Points else { return }
        
        stats.booksRead = calcTotalBooksRead(from: books)
        stats.pagesRead = calcTotalOfPagesRead(from: books)
        stats.daysRead = calcTotalOfDaysRead(from: books)
        stats.minutesRead = calcTotalOfMinutesRead(from: books)
        
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
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
    
    func calcTotalOfDaysRead(from books: [Book?]?) -> Int64 {
        var amountOfDaysRead: Int64 = 0
        
        guard let books = books else { return 0 }
        
        for object in books {
            guard let book = object as Book? else { return 0 }
            // preciso saber quantas vezes o usuario inseriu uma quantidade de paginas
            amountOfDaysRead = book.timesRead
        }
        
        
        return amountOfDaysRead
    }
    
    func calcTotalOfMinutesRead(from books: [Book?]?) -> Int64 {
        var amountOfMinutesRead: Int64 = 0
        
        guard let books = books else { return 0 }
        
        for object in books {
            guard let book = object as Book? else { return 0 }
            // preciso saber quantas vezes o usuario inseriu uma quantidade de paginas multiplicado pelo tempo de leitura que o usuário disponibilizou
            amountOfMinutesRead = book.timesRead * (book.amountOfReadingTimeHour + book.amountOfReadingTimeMinute + book.amountOfReadingTimeSecound)
        }
        
        return amountOfMinutesRead
    }

    

    

}
