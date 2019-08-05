//
//  InputOptionsTVC.swift
//  HolidayReading
//
//  Created by Paula Leite on 04/08/19.
//  Copyright © 2019 Paula Torales Leite. All rights reserved.
//

import UIKit
import CoreData

var inputOption: Int?

class InputOptionsTVC: UITableViewController {

    @IBOutlet var pagesLabel: UILabel!
    @IBOutlet var chaptersLabel: UILabel!
    
    //var book: Book?
    
    var selectedRow: Int = 1
    
    //var context: NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        //book?.inputOption = 0

        // Footer
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //guard let context = context else { return }
        //guard let book = NSEntityDescription.insertNewObject(forEntityName: "Book", into: context) as? Book else { return }
        
        selectedRow = indexPath.row
        if selectedRow == 0 {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            tableView.cellForRow(at: IndexPath(row: 1, section: 0))?.accessoryType = .none
            inputOption = 0
            //book.inputOption = 0
        } else if selectedRow == 1 {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            tableView.cellForRow(at: IndexPath(row: 0, section: 0))?.accessoryType = .none
            inputOption = 1
            //book.inputOption = 1
        }
        
        //(UIApplication.shared.delegate as! AppDelegate).saveContext()
        
    }

}
