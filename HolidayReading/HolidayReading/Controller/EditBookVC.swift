//
//  EditBookVC.swift
//  HolidayReading
//
//  Created by Paula Leite on 01/08/19.
//  Copyright © 2019 Paula Torales Leite. All rights reserved.
//

import UIKit
import CoreData

class EditBookVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var bookImageView: UIImageView!
    
    @IBOutlet var bookNameLabel: UILabel!
    
    @IBOutlet var pagesReadLabel: UILabel!
    
    @IBOutlet var totalPagesLabel: UILabel!
    
    @IBOutlet var daysLeftLabel: UILabel!
    
    @IBOutlet var daysLabel: UILabel!
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var updatePagesRead: UIButton! {
        didSet {
            updatePagesRead.layer.cornerRadius = updatePagesRead.frame.width/2
            updatePagesRead.clipsToBounds = false
            //self.updatePagesRead.layer.borderWidth = 1
            //self.updatePagesRead.layer.borderColor = #colorLiteral(red: 0.8705882353, green: 0.6745098039, blue: 0.2274509804, alpha: 1)
            updatePagesRead.layer.shadowOpacity = 6
            updatePagesRead.layer.shadowRadius = 4
            updatePagesRead.layer.shadowColor = UIColor.lightGray.cgColor
            updatePagesRead.layer.shadowOffset = CGSize.zero
        }
    }
    
    @IBOutlet var deleteBookButton: UIButton! {
        didSet {
            self.deleteBookButton.tintColor = #colorLiteral(red: 0.7976968884, green: 0.354347229, blue: 0.3951124549, alpha: 1)
            self.deleteBookButton.setTitle("Excluir", for: .normal)
            self.deleteBookButton.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)
            self.deleteBookButton.layer.borderWidth = 0.5
            self.deleteBookButton.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
    }
    
    @IBOutlet var deleteBookButtonTopView: UIView!
    
    
    var book: Book?
    
    var originalBook: Book?
    
    var context: NSManagedObjectContext?
    
    var mainVC: MyBooksVC?
    
    var areCellsExpanded = [false, false, false]
    
    var bookChanged = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
        navigationItem.rightBarButtonItem = saveButton
        
        tableView.delegate = self
        tableView.dataSource = self
        
        if let book = book {
            bookNameLabel.text = book.bookName
            pagesReadLabel.text = "\(Int(book.pagesRead))"
            totalPagesLabel.text = "páginas de \(Int(book.amountOfInputOption))"
            daysLeftLabel.text = "\(Int((book.amountOfTimeLeft) * 1.15741e-5))"
            daysLabel.text = "dias sobrando"
        
            guard let data = book.image as Data? else { return }
            bookImageView.image = UIImage(data: data)
            
            updatePagesRead.addTarget(self, action: #selector(updatePagesRead(_:)), for: .touchUpInside)
        }
        
        // Navigation
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        // Footer
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("test")
        
        if !bookChanged {
            book = originalBook
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let book = book else { return UITableViewCell() }
        
        if indexPath.row == 0 {
            if let firstCell = tableView.dequeueReusableCell(withIdentifier: "customPickerCell") as? CustomPickerTVCell {
                
                firstCell.amountOfHoursLabel.text = "\(book.amountOfReadingTimeHour)h, "
                firstCell.amountOfTimeReadingPicker.selectRow(Int(book.amountOfReadingTimeHour), inComponent: 0, animated: true)
                firstCell.amountOfMinutesLabel.text = "\(book.amountOfReadingTimeMinute)m, "
                firstCell.amountOfTimeReadingPicker.selectRow(Int(book.amountOfReadingTimeMinute), inComponent: 1, animated: true)
                firstCell.amountOfSecoundsLabel.text = "\(book.amountOfReadingTimeSecound)s"
                firstCell.amountOfTimeReadingPicker.selectRow(Int(book.amountOfReadingTimeSecound), inComponent: 2, animated: true)
                firstCell.book = book
                mainVC?.updateBook()
                
                return firstCell
                
            }
        } else if indexPath.row == 1 {
            if let secoundCell = tableView.dequeueReusableCell(withIdentifier: "timeDatePickerCell") as? TimeDatePickerTVCell {
                
                
                secoundCell.timeDatePicker?.datePickerMode = .time
                guard let timeOfReading = (book.timeOfReading) as Date? else { return UITableViewCell() }
                secoundCell.timeDatePicker.setDate(timeOfReading, animated: true)
                let timeFormatter = DateFormatter()
                timeFormatter.timeStyle = .short
                secoundCell.timeInfoLabel.text = timeFormatter.string(from: timeOfReading)
                secoundCell.timeDatePicker?.addTarget(secoundCell, action: #selector(TimeDatePickerTVCell.timeChanged(timeOfReadingPicker:)), for: .valueChanged)
                secoundCell.book = book
                mainVC?.updateBook()
                
                return secoundCell
                
            }
        } else {
            if let thirdCell = tableView.dequeueReusableCell(withIdentifier: "datePickerCell") as? DatePickerTVCell {
                
                thirdCell.datePicker?.datePickerMode = .date
                guard let limitDateOfReading = book.limitDataOfReading as Date? else { return UITableViewCell() }
                thirdCell.datePicker.setDate(limitDateOfReading, animated: true)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
                thirdCell.dateInfoLabel.text = dateFormatter.string(from: limitDateOfReading)
                thirdCell.datePicker?.addTarget(thirdCell, action: #selector(DatePickerTVCell.dateChanged(limitOfReadingPicker:)), for: .valueChanged)
                thirdCell.book = book
                mainVC?.updateBook()
                
                return thirdCell
                
            }
        }
        
        return UITableViewCell()
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        
        if indexPath.row >= 0 && indexPath.row < 3 {
            if areCellsExpanded[indexPath.row] {
                areCellsExpanded[indexPath.row] = false
            } else {
                for i in 0 ..< areCellsExpanded.count {
                    areCellsExpanded[i] = false
                }
                areCellsExpanded[indexPath.row] = true
            }
            
            tableView.endUpdates()
        }
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 3 {
            return 44
        } else {
            return areCellsExpanded[indexPath.row] == true ? 212 : 44
        }
    }
    
    @objc func save() {
        bookChanged = true
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        // Está dando o pop, mas está perdendo uma parte da Nav
        self.navigationController?.popViewController(animated: true)
    
    }
    
    @objc func updatePagesRead(_ button: UIButton) {
        
        let updatePagesReadVC = UpdatePagesReadVC()
        updatePagesReadVC.modalPresentationStyle = .custom
        updatePagesReadVC.modalTransitionStyle = .crossDissolve
        updatePagesReadVC.book = book
        //updatePagesReadVC.mainVC = self
        
        present(updatePagesReadVC, animated: true, completion: nil)
        
    }
    
    @IBAction func deleteBook(_ sender: UIButton) {
        
        
        if let book = book {
            
            
            // Declare Alert Message
            let deleteBookAlertController = UIAlertController(title: "Deletar", message: "Você tem certeza que deseja deletar esse livro?", preferredStyle: .alert)
            // Botão de OK
            let botaoSim = UIAlertAction(title: "Sim", style: .default) {
                (action) in
                print("Yes button selected")
                
                // Não está cancelando a notificação
                guard let bookID = book.bookID else { return }
                cancelNotification(forId: bookID)
                
                self.context?.delete(book)
                
                self.tableView.reloadData()
                (UIApplication.shared.delegate as! AppDelegate).saveContext()
                
                // Está dando o pop, mas está perdendo uma parte da Nav
                self.navigationController?.popViewController(animated: true)
                
            }
            
            let botaoNao = UIAlertAction(title: "Cancelar", style: .cancel) {
                (action) in
                print("Cancel button selected")
            }
            
            deleteBookAlertController.addAction(botaoSim)
            deleteBookAlertController.addAction(botaoNao)
            
            self.present(deleteBookAlertController, animated: true, completion: nil)
            
        }
        
    }

}
