//
//  Points+CoreDataProperties.swift
//  HolidayReading
//
//  Created by Paula Leite on 21/07/19.
//  Copyright © 2019 Paula Torales Leite. All rights reserved.
//
//

import Foundation
import CoreData


extension Points {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Points> {
        return NSFetchRequest<Points>(entityName: "Points")
    }

    @NSManaged public var booksRead: Int64
    @NSManaged public var pagesRead: Int64
    @NSManaged public var daysRead: Int64
    @NSManaged public var minutesRead: Int64
    @NSManaged public var pointsMade: Int64

}
