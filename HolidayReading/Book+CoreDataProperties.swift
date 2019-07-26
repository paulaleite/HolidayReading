//
//  Book+CoreDataProperties.swift
//  HolidayReading
//
//  Created by Paula Leite on 24/07/19.
//  Copyright © 2019 Paula Torales Leite. All rights reserved.
//
//

import Foundation
import CoreData


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var amountOfReadingTimeHour: Int64
    @NSManaged public var amountOfReadingTimeMinute: Int64
    @NSManaged public var amountOfReadingTimeSecound: Int64
    @NSManaged public var amountOfTimeLeft: Double
    @NSManaged public var bookName: String?
    @NSManaged public var image: NSData?
    @NSManaged public var lastDayThatRead: NSDate?
    @NSManaged public var limitDataOfReading: NSDate?
    @NSManaged public var numOfPages: Float
    @NSManaged public var pagesRead: Float
    @NSManaged public var timeOfReading: NSDate?
    @NSManaged public var timesRead: Int64
    @NSManaged public var bookID: String?

}
