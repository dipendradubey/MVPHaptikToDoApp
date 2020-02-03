//
//  ToDo+CoreDataProperties.swift
//  MVPHaptikToDoApp
//
//  Created by Dipendra Dubey on 03/02/20.
//  Copyright © 2020 Dipendra. All rights reserved.
//
//

import Foundation
import CoreData


extension ToDo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDo> {
        return NSFetchRequest<ToDo>(entityName: "ToDo")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var datestr: String?
    @NSManaged public var desc: String?
    @NSManaged public var isdeleted: Bool
    @NSManaged public var isimp: Bool
    @NSManaged public var title: String?
    @NSManaged public var iscompleted: Bool

}
