//
//  Book+CoreDataProperties.swift
//  HolidayReading
//
//  Created by Paula Leite on 16/07/19.
//  Copyright © 2019 Paula Torales Leite. All rights reserved.
//
//

import Foundation
import CoreData


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var amountOfReadingTimeHour: Double
    @NSManaged public var bookName: String?
    @NSManaged public var numOfPages: Int64
    @NSManaged public var pagesRead: Int64
    @NSManaged public var id: String?
    @NSManaged public var amountOfReadingTimeMinute: Double
    @NSManaged public var amountOfReadingTimeSecound: Double
    @NSManaged public var amountOfTimeLeft: Int64
    @NSManaged public var limitDataOfReading: NSDate?
    @NSManaged public var timeOfReading: NSDate?

}
