//
//  UpdatePagesReadVC.swift
//  HolidayReading
//
//  Created by Paula Leite on 14/07/19.
//  Copyright © 2019 Paula Torales Leite. All rights reserved.
//

import UIKit
import CoreData

class UpdatePagesReadVC: UIViewController {

    var book: Book?
    
    //var MainTVC: MyBooksTVC?
    
    var mainVC: MyBooksVC?
    
    @IBOutlet var amountOfPagesSlider: UISlider!
    
    @IBOutlet var amountOfPagesLabel: UILabel!
    
    @IBOutlet var bgView: UIView!
    
    @IBOutlet var titleLabel: UILabel!
    
    var context: NSManagedObjectContext?
    
    let increments: Float = 1
    
    var stats: [Statistics] = []
    var books: [Book] = []
    
    @IBOutlet var addButton: UIButton! {
        didSet {
            addButton.layer.cornerRadius = 10
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissVC))
        bgView.addGestureRecognizer(tap)
        tap.cancelsTouchesInView = true
        
        guard let numOfPages = book?.amountOfInputOption else { return }
        guard let amountOfPages = book?.pagesRead else { return }
        amountOfPagesSlider.maximumValue = numOfPages - amountOfPages
        
        amountOfPagesSlider.minimumValue = 0
        
        do {
            guard let context = context else { return }
            stats = try context.fetch(Statistics.fetchRequest())
            books = try context.fetch(Book.fetchRequest())
            
            if stats.count == 0 {
                guard let stats = NSEntityDescription.insertNewObject(forEntityName: "Statistics", into: context) as? Statistics else { return }
                
                stats.booksRead = calcTotalBooksRead(from: books)
                stats.pagesRead = calcTotalOfPagesRead(from: books)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if inputOption == 0 {
            titleLabel.text = "Quantidade de Páginas Lidas"
        } else {
            titleLabel.text = "Quantidade de Capítulos Lidos"
        }
        
    }
    
    @objc func dismissVC() {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func associateAmountOfPages(_ sender: Any) {
        
        book?.pagesRead += amountOfPagesSlider.value
        
        // Amount of days reading
        let currentCalendar = Calendar.autoupdatingCurrent
        let currentComponents = currentCalendar.dateComponents([.day, .month, .year], from: Date())
        let currentDay = currentComponents.day
        let currentMonth = currentComponents.month
        let currentYear = currentComponents.year
        
        if stats[0].lastDayRead != nil {
            guard let date = stats[0].lastDayRead as Date? else { return }
            let calendar = Calendar.autoupdatingCurrent
            let components = calendar.dateComponents([.day, .month, .year], from: date)
            let day = components.day
            let month = components.month
            let year = components.year

            
            if day != currentDay || month != currentMonth || year != currentYear {
                stats[0].lastDayRead = NSDate()
                stats[0].daysRead += 1
                book?.timesRead += 1
            }
        } else {
            stats[0].lastDayRead = NSDate()
            stats[0].daysRead += 1
            book?.timesRead += 1
        }
        
        //(UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        // Putting this info in the statistics TVC
        stats[0].booksRead = calcTotalBooksRead(from: books)
        stats[0].pagesRead = calcTotalOfPagesRead(from: books)
        stats[0].minutesRead = calcTotalOfMinutesRead(from: books, from: stats)
        stats[0].pointsMade = calcTotalPoint(from: stats)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        mainVC?.updateBook()
        
        dismissVC()
        
    }
    
    // Code #10 of CBL Document File (https://paper.dropbox.com/doc/CBL-Document-Paula--Ag8Oeg_7LmUEIWysuJgmYuXEAQ-zck3kpaQYAspQuFvAsOxk)
    @IBAction func sliderValueChanged(_ sender: Any) {
        
        // Code #9 of CBL Document File (https://paper.dropbox.com/doc/CBL-Document-Paula--Ag8Oeg_7LmUEIWysuJgmYuXEAQ-zck3kpaQYAspQuFvAsOxk)
        let roundedValue = round(amountOfPagesSlider.value / increments) * increments
        amountOfPagesSlider.value = roundedValue
        
        amountOfPagesLabel.text = "\(Int(amountOfPagesSlider.value))"
    }
    
    func calcTotalBooksRead(from books: [Book?]?) -> Int64 {
        var amountOfBooksRead: Int64 = 0
        
        guard let books = books else { return 0 }
        
        for object in books {
            guard let book = object as Book? else { return 0 }
            
            if book.pagesRead == book.amountOfInputOption {
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
    
    func calcTotalOfMinutesRead(from books: [Book?]?, from stats: [Statistics?]?) -> Int64 {
        var amountOfMinutesRead: Int64 = 0
        
        guard let books = books else { return 0 }
        guard let stats = stats else { return 0 }
        
        
        for object in books {
            guard let book = object as Book? else { return 0 }
            for object2 in stats {
                guard let stat = object2 as Statistics? else { return 0 }
                amountOfMinutesRead += stat.daysRead * ((book.amountOfReadingTimeHour * 60) + book.amountOfReadingTimeMinute + (book.amountOfReadingTimeSecound / 60))
            }
            
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
