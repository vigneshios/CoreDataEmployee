//
//  Employee+CoreDataProperties.swift
//  CoreData-SavingDataToDevice
//
//  Created by Apple on 22/02/18.
//  Copyright © 2018 Vignesh. All rights reserved.
//
//

import Foundation
import CoreData


extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var name: String?
    @NSManaged public var designation: String?

}
