//
//  User+CoreDataProperties.swift
//  EYNTA
//
//  Created by James Slusser on 11/18/19.
//  Copyright © 2019 James Slusser. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String?

}
