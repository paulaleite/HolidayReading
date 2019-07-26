//
//  Statistics+CoreDataProperties.swift
//  HolidayReading
//
//  Created by Paula Leite on 24/07/19.
//  Copyright © 2019 Paula Torales Leite. All rights reserved.
//
//

import Foundation
import CoreData


extension Statistics {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Statistics> {
        return NSFetchRequest<Statistics>(entityName: "Statistics")
    }

    @NSManaged public var booksRead: Int64
    @NSManaged public var daysRead: Int64
    @NSManaged public var minutesRead: Int64
    @NSManaged public var pagesRead: Int64
    @NSManaged public var pointsMade: Int64
    @NSManaged public var lastDayRead: NSDate?

}
