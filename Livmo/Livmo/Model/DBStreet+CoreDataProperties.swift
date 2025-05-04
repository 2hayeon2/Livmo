//
//  DBStreet+CoreDataProperties.swift
//  Livmo
//
//  Created by hayeon lee on 5/4/25.
//
//

import Foundation
import CoreData


extension DBStreet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBStreet> {
        return NSFetchRequest<DBStreet>(entityName: "DBStreet")
    }

    @NSManaged public var uid: String?
    @NSManaged public var partType: Int16
    @NSManaged public var blockList: NSOrderedSet?

}

// MARK: Generated accessors for blockList
extension DBStreet {

    @objc(insertObject:inBlockListAtIndex:)
    @NSManaged public func insertIntoBlockList(_ value: DBBlock, at idx: Int)

    @objc(removeObjectFromBlockListAtIndex:)
    @NSManaged public func removeFromBlockList(at idx: Int)

    @objc(insertBlockList:atIndexes:)
    @NSManaged public func insertIntoBlockList(_ values: [DBBlock], at indexes: NSIndexSet)

    @objc(removeBlockListAtIndexes:)
    @NSManaged public func removeFromBlockList(at indexes: NSIndexSet)

    @objc(replaceObjectInBlockListAtIndex:withObject:)
    @NSManaged public func replaceBlockList(at idx: Int, with value: DBBlock)

    @objc(replaceBlockListAtIndexes:withBlockList:)
    @NSManaged public func replaceBlockList(at indexes: NSIndexSet, with values: [DBBlock])

    @objc(addBlockListObject:)
    @NSManaged public func addToBlockList(_ value: DBBlock)

    @objc(removeBlockListObject:)
    @NSManaged public func removeFromBlockList(_ value: DBBlock)

    @objc(addBlockList:)
    @NSManaged public func addToBlockList(_ values: NSOrderedSet)

    @objc(removeBlockList:)
    @NSManaged public func removeFromBlockList(_ values: NSOrderedSet)

}

extension DBStreet : Identifiable {

}
