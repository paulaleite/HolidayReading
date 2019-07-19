//
//  EditBookTVC.swift
//  HolidayReading
//
//  Created by Paula Leite on 12/07/19.
//  Copyright © 2019 Paula Torales Leite. All rights reserved.
//

import UIKit
import CoreData

class EditBookTVC: UITableViewController {
    
    
    @IBOutlet var pagesProgressBar: ProgressBarView!
    
    @IBOutlet weak var pagesLabel: UILabel!
    
    @IBOutlet var daysReadingLabel: UILabel!
    
    @IBOutlet var timeOfReadingPerDayLabelHour: UILabel!
    
    @IBOutlet var timeOfReadingPerDayLabelMinute: UILabel!
    
    @IBOutlet var timeOfReadingPerDayLabelSecound: UILabel!
    
    @IBOutlet var timeOfReadingPerDayPicker: UIPickerView!
    
    @IBOutlet var timeOfReadingLabel: UILabel!
    
    @IBOutlet var timeOfReadingPicker: UIDatePicker!
    
    @IBOutlet var limitOfReadingLabel: UILabel!
    
    @IBOutlet var limitOfReadingPicker: UIDatePicker!
    
    @IBOutlet var readingUpdateButton: UIButton!
    
    var areCellsExpanded = [false, false, false]
    
    var timeOfReadingPerDayPickerData: [[String]] = [[String]]()
    
    var hour: String = ""
    var minutes: String = ""
    var secound: String = ""
    
    var book: Book?
    
    var books: [Book]?
    
    var MainTVC: MyBooksTVC?
    
    var isInEditingMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Amount of Time Picker
        self.timeOfReadingPerDayPicker.delegate = self
        self.timeOfReadingPerDayPicker.dataSource = self
        timeOfReadingPerDayPickerData = [["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23"],
                                         ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23",
                                          "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47",
                                          "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59"],
                                         ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23",
                                          "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47",
                                          "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59"]]
        
        // Footer
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        if let book = book {
            
            timeOfReadingPerDayLabelHour.text = "\(book.amountOfReadingTimeHour)h, "
            timeOfReadingPerDayPicker.selectRow(Int(book.amountOfReadingTimeHour), inComponent: 0, animated: true)
            timeOfReadingPerDayLabelMinute.text = "\(book.amountOfReadingTimeMinute)m, "
            timeOfReadingPerDayPicker.selectRow(Int(book.amountOfReadingTimeMinute), inComponent: 1, animated: true)
            timeOfReadingPerDayLabelSecound.text = "\(book.amountOfReadingTimeSecound)s"
            timeOfReadingPerDayPicker.selectRow(Int(book.amountOfReadingTimeSecound), inComponent: 2, animated: true)
            // Time Picker
            timeOfReadingPicker?.datePickerMode = .time
            timeOfReadingPicker.setDate((book.timeOfReading)! as Date, animated: true)
            let timeFormatter = DateFormatter()
            timeFormatter.timeStyle = .short
            timeOfReadingLabel.text = timeFormatter.string(from: (book.timeOfReading)! as Date)
            timeOfReadingPicker?.addTarget(self, action: #selector(timeChanged(timeOfReadingPicker:)), for: .valueChanged)
            // Date Picker
            limitOfReadingPicker?.datePickerMode = .date
            limitOfReadingPicker.setDate((book.limitDataOfReading)! as Date, animated: true)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
            limitOfReadingLabel.text = dateFormatter.string(from: (book.limitDataOfReading)! as Date)
            limitOfReadingPicker?.addTarget(self, action: #selector(dateChanged(limitOfReadingPicker:)), for: .valueChanged)
            // Progress Bar
//            self.pagesProgressBar.lineWidth = 5.0
//            pagesProgressBar.progressValue = CGFloat(book.pagesRead)
            self.pagesProgressBar.progressValue = CGFloat(book.pagesRead/book.numOfPages)
            pagesLabel.text = "\(Int(book.pagesRead))"
            
            
            daysReadingLabel.text = "\(calcTotalOfDaysRead(from: book))"
            
        }
        
        readingUpdateButton.layer.cornerRadius = 10
        
    }
    
    // Code #4 of CBL Document File (https://paper.dropbox.com/doc/CBL-Document-Paula--Ag8Oeg_7LmUEIWysuJgmYuXEAQ-zck3kpaQYAspQuFvAsOxk)
    @objc func dateChanged(limitOfReadingPicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        limitOfReadingLabel.text = dateFormatter.string(from: limitOfReadingPicker.date)
    }
    
    // Code #5 of CBL Document File (https://paper.dropbox.com/doc/CBL-Document-Paula--Ag8Oeg_7LmUEIWysuJgmYuXEAQ-zck3kpaQYAspQuFvAsOxk)
    @objc func timeChanged(timeOfReadingPicker: UIDatePicker) {
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .short
        timeOfReadingLabel.text = timeFormatter.string(from: timeOfReadingPicker.date)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            if areCellsExpanded[indexPath.row] {
                areCellsExpanded[indexPath.row] = false
            } else {
                for i in 0 ..< areCellsExpanded.count {
                    areCellsExpanded[i] = false
                }
                areCellsExpanded[indexPath.row] = true
            }
            
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 || indexPath.section == 2 {
            return 44
        } else {
            return areCellsExpanded[indexPath.row] == true ? 212 : 44
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 200))
        
        if section == 0 {
            headerView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            let headerLabel = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.bounds.size.width, height: 50))
            headerLabel.textColor = #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5764705882, alpha: 1)
            //headerLabel.
            headerLabel.text = "Informações"
            headerLabel.textAlignment = .left
            headerView.addSubview(headerLabel)

        } else if section == 1 {
            headerView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            let headerLabel = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.bounds.size.width, height: 50))
            headerLabel.textColor = #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5764705882, alpha: 1)
            headerLabel.text = "Editáveis"
            headerLabel.textAlignment = .left
            headerView.addSubview(headerLabel)
            
            let addButton = CustomButton(type: .custom)
            addButton.id = section
            addButton.setTitle(isInEditingMode ? "Adicionar" : "Adicionar", for: .normal)
            addButton.titleLabel?.font = UIFont(name: "SF-Pro-Display-Regular", size: 17)
            addButton.addTarget(self, action: #selector(saveInformation), for: .touchUpInside)
            addButton.setTitleColor(#colorLiteral(red: 0.2549019608, green: 0.231372549, blue: 0.537254902, alpha: 1), for: .normal)
            addButton.titleLabel?.textAlignment = .right
            headerView.addSubview(addButton)
            
            addButton.translatesAutoresizingMaskIntoConstraints = false
            addButton.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: 0).isActive = true
            addButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
            addButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
            
            let tapPress = UITapGestureRecognizer(target: self, action: #selector(tapped))
            view.addGestureRecognizer(tapPress)
            tapPress.cancelsTouchesInView = false
        } else {
            headerView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    @objc func tapped() {
        isInEditingMode = !isInEditingMode
    }
    
    
    @objc func saveInformation() {
        guard let numOfHours = Int64(timeOfReadingPerDayPickerData[0][timeOfReadingPerDayPicker.selectedRow(inComponent: 0)]) else { return }
        book?.amountOfReadingTimeHour = numOfHours
    
        guard let numOfMinutes = Int64(timeOfReadingPerDayPickerData[1][timeOfReadingPerDayPicker.selectedRow(inComponent: 1)]) else { return }
        book?.amountOfReadingTimeMinute = numOfMinutes
    
        guard let numOfSecound = Int64(timeOfReadingPerDayPickerData[2][timeOfReadingPerDayPicker.selectedRow(inComponent: 2)]) else { return }
        book?.amountOfReadingTimeSecound = numOfSecound
    
        book?.timeOfReading = timeOfReadingPicker.date as NSDate
    
        book?.limitDataOfReading = limitOfReadingPicker.date as NSDate
    
    
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    
        MainTVC?.updateBook()
    }
    
    func calcTotalOfDaysRead(from book: Book?) -> Int64 {
        var amountOfDaysRead: Int64 = 10
        
        guard let book = book else { return 0 }
        
        // preciso saber quantas vezes o usuario inseriu uma quantidade de paginas
        amountOfDaysRead = book.timesRead
        
        return amountOfDaysRead
    }
    

}
