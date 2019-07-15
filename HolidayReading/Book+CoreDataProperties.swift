//
//  Book+CoreDataProperties.swift
//  HolidayReading
//
//  Created by Paula Leite on 14/07/19.
//  Copyright © 2019 Paula Torales Leite. All rights reserved.
//
//

import Foundation
import CoreData


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var bookName: String?
    @NSManaged public var numOfPages: Int64
    @NSManaged public var amountOfReadingTime: Double
    @NSManaged public var readingSchedule: NSDate?
    @NSManaged public var limitOfReading: NSDate?
    @NSManaged public var pagesRead: Int64

}
