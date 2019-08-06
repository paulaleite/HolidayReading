//
//  MyBooksVC.swift
//  HolidayReading
//
//  Created by Paula Leite on 01/08/19.
//  Copyright © 2019 Paula Torales Leite. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import UserNotifications

class MyBooksVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var books: [Book] = [] // This needs CoreData to work
    var book: Book?
    var noBooksImage:UIImageView = UIImageView(image: UIImage(named: "noBooks"))
    
    var context: NSManagedObjectContext?
    var selectedBookIndex = 0
    

    
    @IBOutlet var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        collectionView.delegate = self
        
        navigationItem.title = "Meus Livros"
        
        noBooksImage.frame = CGRect(x: 0, y: 0, width: 0.392 * UIScreen.main.bounds.width, height: 0.3333 * UIScreen.main.bounds.width)
        self.view.addSubview(noBooksImage)
        noBooksImage.center.x = self.view.center.x
        noBooksImage.center.y = self.view.center.y - 80
        
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        do {
            guard let context = context else { return }
            books = try context.fetch(Book.fetchRequest())
            
            collectionView.reloadData()
            
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

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return The number of rows in section.
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedBookIndex = indexPath.row
        performSegue(withIdentifier: "editSegue", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //return A configured cell object.
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "proCell", for: indexPath) as? MyBookCVCell {
            cell.bookNameLabel.text = books[indexPath.row].bookName
            cell.pagesLeftLabel.text = "\(Int(books[indexPath.row].pagesRead))"
            if inputOption == 0 {
                cell.pagesLabel.text = "páginas de \(Int(books[indexPath.row].amountOfInputOption))"
            } else {
                cell.pagesLabel.text = "capítulos de \(Int(books[indexPath.row].amountOfInputOption))"
            }
            
            cell.daysLeftLabel.text = "\(Int((books[indexPath.row].amountOfTimeLeft) * 1.15741e-5))"
            cell.daysLabel.text = "dias sobrando"
            
            if books[indexPath.row].image == noImage {
                cell.bookImage.image = UIImage(named: "placeholder")
            } else {
                guard let data = books[indexPath.row].image as Data? else { return UICollectionViewCell()}
                cell.bookImage.image = UIImage(data: data)
            }
            
            cell.updatePagesRead.tag = indexPath.row
            cell.updatePagesRead.addTarget(self, action: #selector(updatePagesRead(_:)), for: .touchUpInside)
            
            return cell
        }
        
        
        return UICollectionViewCell()
    }
    
    @objc func updatePagesRead(_ button: UIButton) {
        selectedBookIndex = button.tag
        
        let updatePagesReadVC = UpdatePagesReadVC()
        updatePagesReadVC.modalPresentationStyle = .custom
        updatePagesReadVC.modalTransitionStyle = .crossDissolve
        updatePagesReadVC.book = books[selectedBookIndex]
        updatePagesReadVC.mainVC = self
        
        present(updatePagesReadVC, animated: true, completion: nil)
        
    }
    
    func updateBook() {
        do {
            guard let context = context else { return }
            books = try context.fetch(Book.fetchRequest())
            collectionView.reloadData()
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
        if let editBookVC = segue.destination as? EditBookVC {
            editBookVC.book = books[selectedBookIndex]
            editBookVC.originalBook = books[selectedBookIndex]
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 352 538
        let width = (352 / 414) * UIScreen.main.bounds.width
        let height = (538 / 896) * UIScreen.main.bounds.height

        return CGSize(width: width, height: height)
    }

}
