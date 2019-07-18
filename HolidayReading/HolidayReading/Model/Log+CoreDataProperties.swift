//
//  Log+CoreDataProperties.swift
//  HolidayReading
//
//  Created by Paula Leite on 18/07/19.
//  Copyright © 2019 Paula Torales Leite. All rights reserved.
//
//

import Foundation
import CoreData


extension Log {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Log> {
        return NSFetchRequest<Log>(entityName: "Log")
    }

    @NSManaged public var amoutOfPagesReadCounter: Int64
    @NSManaged public var amountOfBooksReadCounter: Int64
    @NSManaged public var totalAmountOfPagesReadCounter: Int64
    @NSManaged public var amoutOfDaysReadCounter: Int64
    @NSManaged public var amountOfMinutesReadCounter: Int64

}
