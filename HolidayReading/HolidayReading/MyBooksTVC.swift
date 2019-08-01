//
//  MyBooksTVC.swift
//  HolidayReading
//
//  Created by Paula Leite on 06/07/19.
//  Copyright © 2019 Paula Torales Leite. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import UserNotifications

class MyBooksTVC: UITableViewController {

    var books: [Book] = [] // This needs CoreData to work
    var book: Book?
    var noBooksImage:UIImageView = UIImageView(image: UIImage(named: "noBooks")) // Image used when there aren't any Books (so, the first time it opens)
    
    var context: NSManagedObjectContext?
    var selectedBookIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        tableView.dataSource = self
        tableView.delegate = self
        navigationItem.title = "Meus Livros"
        tableView.rowHeight = 133
        
        noBooksImage.frame = CGRect(x: 0, y: 0, width: 0.392 * UIScreen.main.bounds.width, height: 0.3333 * UIScreen.main.bounds.width)
        self.view.addSubview(noBooksImage)
        noBooksImage.center.x = self.view.center.x
        noBooksImage.center.y = self.view.center.y - 80
        
        navigationItem.leftBarButtonItem = editButtonItem
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
        do {
            guard let context = context else { return }
            books = try context.fetch(Book.fetchRequest())
            
            tableView.reloadData()
            
        } catch let error {
            print(error.localizedDescription)
        }
        
        if books.count == 0 {
            noBooksImage.isHidden = false
            self.navigationItem.leftBarButtonItem?.isEnabled = false
        } else {
            noBooksImage.isHidden = true
            self.navigationItem.leftBarButtonItem?.isEnabled = true
        }
        
        updateBook()
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "bookInfo") as? MyBooksTVCell {
            cell.bookTitle.text = books[indexPath.row].bookName
            cell.numOfPages.text = "\(Int(books[indexPath.row].pagesRead)) de \(Int(books[indexPath.row].numOfPages))"
            cell.timeLeft.text = "\(Int((books[indexPath.row].amountOfTimeLeft) * 1.15741e-5)) dias"
            
            if books[indexPath.row].image == noImage {
                cell.bookImage.image = UIImage(named: "placeholder")
            } else {
                guard let data = books[indexPath.row].image as Data? else { return UITableViewCell()}
                cell.bookImage.image = UIImage(data: data)
            }
            
            cell.updatePagesReadButton.tag = indexPath.row
            cell.updatePagesReadButton.addTarget(self, action: #selector(updatePagesRead(_:)), for: .touchUpInside)
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedBookIndex = indexPath.row
        performSegue(withIdentifier: "editSegue", sender: self)
    }
    
    // Deletion of Book
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            context?.delete(books[indexPath.row])
            books.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            tableView.reloadData()
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
  
            if self.books.count == 0 {
                self.noBooksImage.isHidden = false
                self.navigationItem.leftBarButtonItem?.isEnabled = false
            } else {
                self.noBooksImage.isHidden = true
                self.navigationItem.leftBarButtonItem?.isEnabled = true
            }
            
            guard let bookID = book?.bookID else { return }
            cancelNotification(forId: bookID, categoria: 0)
            cancelNotification(forId: bookID, categoria: 1)
            
            
        }
    }
    
    // Code #1 of CBL Document File (https://paper.dropbox.com/doc/CBL-Document-Paula--Ag8Oeg_7LmUEIWysuJgmYuXEAQ-zck3kpaQYAspQuFvAsOxk)
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if tableView.isEditing {
            return true
        }
        return false
    }
    
    @objc func updatePagesRead(_ button: UIButton) {
        selectedBookIndex = button.tag
        
        let updatePagesReadVC = UpdatePagesReadVC()
        updatePagesReadVC.modalPresentationStyle = .custom
        updatePagesReadVC.modalTransitionStyle = .crossDissolve
        updatePagesReadVC.book = books[selectedBookIndex]
        //updatePagesReadVC.MainTVC = self
        
        present(updatePagesReadVC, animated: true, completion: nil)
        
    }
    
    func updateBook() {
        do {
            guard let context = context else { return }
            books = try context.fetch(Book.fetchRequest())
            tableView.reloadData()
        } catch let error {
            print(error.localizedDescription)
        }

        
        if books.count == 0 {
            noBooksImage.isHidden = false
            self.navigationItem.leftBarButtonItem?.isEnabled = false
        } else {
            noBooksImage.isHidden = true
            self.navigationItem.leftBarButtonItem?.isEnabled = true
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let editBookTVC = segue.destination as? EditBookTVC {
            editBookTVC.book = books[selectedBookIndex]
        }
    }
    
}
