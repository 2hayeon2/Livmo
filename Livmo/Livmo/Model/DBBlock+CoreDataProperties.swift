//
//  DBBlock+CoreDataProperties.swift
//  Livmo
//
//  Created by hayeon lee on 5/4/25.
//
//

import Foundation
import CoreData


extension DBBlock {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBBlock> {
        return NSFetchRequest<DBBlock>(entityName: "DBBlock")
    }

    @NSManaged public var uid: String?
    @NSManaged public var title: String?
    @NSManaged public var tagList: NSOrderedSet?

}

// MARK: Generated accessors for tagList
extension DBBlock {

    @objc(insertObject:inTagListAtIndex:)
    @NSManaged public func insertIntoTagList(_ value: DBTag, at idx: Int)

    @objc(removeObjectFromTagListAtIndex:)
    @NSManaged public func removeFromTagList(at idx: Int)

    @objc(insertTagList:atIndexes:)
    @NSManaged public func insertIntoTagList(_ values: [DBTag], at indexes: NSIndexSet)

    @objc(removeTagListAtIndexes:)
    @NSManaged public func removeFromTagList(at indexes: NSIndexSet)

    @objc(replaceObjectInTagListAtIndex:withObject:)
    @NSManaged public func replaceTagList(at idx: Int, with value: DBTag)

    @objc(replaceTagListAtIndexes:withTagList:)
    @NSManaged public func replaceTagList(at indexes: NSIndexSet, with values: [DBTag])

    @objc(addTagListObject:)
    @NSManaged public func addToTagList(_ value: DBTag)

    @objc(removeTagListObject:)
    @NSManaged public func removeFromTagList(_ value: DBTag)

    @objc(addTagList:)
    @NSManaged public func addToTagList(_ values: NSOrderedSet)

    @objc(removeTagList:)
    @NSManaged public func removeFromTagList(_ values: NSOrderedSet)

}

extension DBBlock : Identifiable {

}
