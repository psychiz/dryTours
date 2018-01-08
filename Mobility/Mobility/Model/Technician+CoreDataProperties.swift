//
//  Technician+CoreDataProperties.swift
//  
//
//
//

import Foundation
import CoreData


extension Technician {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Technician> {
        return NSFetchRequest<Technician>(entityName: "Technician")
    }

    @NSManaged public var displayName: String?
    @NSManaged public var id: Int32
    @NSManaged public var loginID: String?
    @NSManaged public var defaultSite: String?
    @NSManaged public var email: String?

}
