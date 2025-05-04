//
//  DBTag+CoreDataProperties.swift
//  Livmo
//
//  Created by hayeon lee on 5/4/25.
//
//

import Foundation
import CoreData


extension DBTag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBTag> {
        return NSFetchRequest<DBTag>(entityName: "DBTag")
    }

    @NSManaged public var title: String?

}

extension DBTag : Identifiable {

}
