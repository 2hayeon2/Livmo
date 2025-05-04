//
//  DBDay+CoreDataProperties.swift
//  Livmo
//
//  Created by hayeon lee on 5/4/25.
//
//

import Foundation
import CoreData


extension DBDay {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBDay> {
        return NSFetchRequest<DBDay>(entityName: "DBDay")
    }

    @NSManaged public var uid: String?
    @NSManaged public var title: String?
    @NSManaged public var streetList: NSOrderedSet?

}

// MARK: Generated accessors for streetList
extension DBDay {

    @objc(insertObject:inStreetListAtIndex:)
    @NSManaged public func insertIntoStreetList(_ value: DBStreet, at idx: Int)

    @objc(removeObjectFromStreetListAtIndex:)
    @NSManaged public func removeFromStreetList(at idx: Int)

    @objc(insertStreetList:atIndexes:)
    @NSManaged public func insertIntoStreetList(_ values: [DBStreet], at indexes: NSIndexSet)

    @objc(removeStreetListAtIndexes:)
    @NSManaged public func removeFromStreetList(at indexes: NSIndexSet)

    @objc(replaceObjectInStreetListAtIndex:withObject:)
    @NSManaged public func replaceStreetList(at idx: Int, with value: DBStreet)

    @objc(replaceStreetListAtIndexes:withStreetList:)
    @NSManaged public func replaceStreetList(at indexes: NSIndexSet, with values: [DBStreet])

    @objc(addStreetListObject:)
    @NSManaged public func addToStreetList(_ value: DBStreet)

    @objc(removeStreetListObject:)
    @NSManaged public func removeFromStreetList(_ value: DBStreet)

    @objc(addStreetList:)
    @NSManaged public func addToStreetList(_ values: NSOrderedSet)

    @objc(removeStreetList:)
    @NSManaged public func removeFromStreetList(_ values: NSOrderedSet)

}

extension DBDay : Identifiable {

}
