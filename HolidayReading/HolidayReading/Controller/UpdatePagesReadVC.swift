//
//  UpdatePagesReadVC.swift
//  HolidayReading
//
//  Created by Paula Leite on 14/07/19.
//  Copyright © 2019 Paula Torales Leite. All rights reserved.
//

import UIKit

class UpdatePagesReadVC: UIViewController {

    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(book)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissVC))
        self.view.addGestureRecognizer(tap)
    }
    
    
    @objc func dismissVC() {
        dismiss(animated: true, completion: nil)
    }

}
