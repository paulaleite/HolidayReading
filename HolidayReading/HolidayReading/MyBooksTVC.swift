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

class MyBooksTVC: UITableViewController {

    var bookInformation:[String] = [] // This needs CoreData to work
    var noBooksImage:UIImageView = UIImageView(image: UIImage(named: "NoBooks.png")) // Image used when there aren't any Books (so, the first time it opens)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        navigationItem.title = "Meus Livros"
        tableView.rowHeight = 133
    }

    override func viewWillAppear(_ animated: Bool) {
        if bookInformation.count == 0 {
            noBooksImage.frame = CGRect(x: 0, y: 0, width: 323, height: 274)
            self.view.addSubview(noBooksImage)
            noBooksImage.center.x = self.view.center.x
            noBooksImage.center.y = self.view.center.y - 80
        }
        
        tableView.reloadData()
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return bookInformation.count
    }

    

}
