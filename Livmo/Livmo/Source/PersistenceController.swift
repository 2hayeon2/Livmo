//
//  PersistenceController.swift
//  Livmo
//
//  Created by hayeon lee on 5/4/25.
//

import Foundation
import CoreData

typealias DB = PersistenceController

class PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }

    func saveContext() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

// MARK: DBBlock
extension PersistenceController {
    func saveBlock(_ block: Block) {
        let context = PersistenceController.shared.container.viewContext
        
        let request: NSFetchRequest<DBBlock> = DBBlock.fetchRequest()
        request.predicate = NSPredicate(format: "uid == %@", block.uid)
        
        do {
            let result = try context.fetch(request)
            
            let dbBlock: DBBlock
            if let existingBlock = result.first {
                dbBlock = existingBlock
            } else {
                dbBlock = DBBlock(context: context)
            }
            
            dbBlock.title = block.title
            dbBlock.uid = block.uid
            
            let newTags = block.tagList.map { tag -> DBTag in
                let newTag = DBTag(context: context)
                newTag.title = tag.title
                return newTag
            }
            
            dbBlock.tagList = NSOrderedSet(array: newTags)
            
            try context.save()
            Log.info("Block saved successfully!")
            
        } catch {
            Log.error("Failed to save block: \(error)")
        }
    }

    
    func fetchBlock(withUID uid: String) -> Block? {
        let context = PersistenceController.shared.container.viewContext
        
        let request: NSFetchRequest<DBBlock> = DBBlock.fetchRequest()
        request.predicate = NSPredicate(format: "uid == %@", uid)
        
        do {
            let result = try context.fetch(request)
            guard let block = result.first else {
                return nil
            }
            
            guard let uid = block.uid, let title = block.title else {
                Log.fault("Missing uid or title in DBBlock")
                return nil
            }
            
            guard let dbTagList = block.tagList?.array as? [DBTag] else {
                Log.fault("Failed to convert tagList to [DBTag]")
                return nil
            }
            
            let tagList: [Tag] = dbTagList.compactMap { dbTag in
                guard let tagTitle = dbTag.title else {
                    Log.fault("Missing title in DBTag")
                    return nil
                }
                return Tag(title: tagTitle)
            }
            
            return Block(uid: uid, title: title, tagList: tagList)
            
        } catch {
            Log.fault("Failed to fetch Block: \(error)")
            return nil
        }
    }

}

// MARK: DBTag
extension PersistenceController {
    
    func saveTag(_ tag: Tag) {
        let context = PersistenceController.shared.container.viewContext
        
        let request: NSFetchRequest<DBTag> = DBTag.fetchRequest()
        request.predicate = NSPredicate(format: "title == %@", tag.title)
        
        do {
            let result = try context.fetch(request)
            
            let dbTag: DBTag
            if let existingTag = result.first {
                dbTag = existingTag
            } else {
                dbTag = DBTag(context: context)
            }
            
            dbTag.title = tag.title
            
            try context.save()
            Log.info("Tag saved successfully!")
        } catch {
            Log.error("Failed to save tag: \(error)")
        }
    }
    
    func fetchTag(withTitle title: String) -> Tag? {
        let context = PersistenceController.shared.container.viewContext
        
        let request: NSFetchRequest<DBTag> = DBTag.fetchRequest()
        request.predicate = NSPredicate(format: "title == %@", title)
        
        do {
            let result = try context.fetch(request)
            guard let dbTag = result.first else {
                return nil
            }
            return Tag(title: dbTag.title ?? "")
        } catch {
            Log.fault("Failed to fetch Tag: \(error)")
            return nil
        }
    }
}

// MARK: DBStreet
extension PersistenceController {
    
    func saveStreet(_ street: Street) {
        let context = PersistenceController.shared.container.viewContext
        
        let request: NSFetchRequest<DBStreet> = DBStreet.fetchRequest()
        request.predicate = NSPredicate(format: "uid == %@", street.uid)
        
        do {
            let result = try context.fetch(request)
            
            let dbStreet: DBStreet
            if let existingStreet = result.first {
                dbStreet = existingStreet
            } else {
                dbStreet = DBStreet(context: context)
            }
            
            dbStreet.uid = street.uid
            dbStreet.partType = street.partType.rawValue
            
            let newBlocks = street.blockList.map { block -> DBBlock in
                let newBlock = DBBlock(context: context)
                newBlock.uid = block.uid
                newBlock.title = block.title
                return newBlock
            }
            dbStreet.blockList = NSOrderedSet(array: newBlocks)
            
            try context.save()
            Log.info("Street saved successfully!")
        } catch {
            Log.error("Failed to save street: \(error)")
        }
    }
    
    func fetchStreet(withUID uid: String) -> Street? {
        let context = PersistenceController.shared.container.viewContext
        
        let request: NSFetchRequest<DBStreet> = DBStreet.fetchRequest()
        request.predicate = NSPredicate(format: "uid == %@", uid)
        
        do {
            let result = try context.fetch(request)
            guard let dbStreet = result.first else {
                return nil
            }
            
            guard let uid = dbStreet.uid else {
                Log.fault("Missing uid in DBStreet")
                return nil
            }
            guard let partType = DayPartType(rawValue: dbStreet.partType) else {
                Log.fault("Invalid partType value in DBStreet")
                return nil
            }
            
            let blockList: [Block] = (dbStreet.blockList?.array as? [DBBlock])?.map { dbBlock in
                Block(uid: dbBlock.uid ?? "", title: dbBlock.title ?? "", tagList: [])
            } ?? []
            
            return Street(uid: uid, partType: partType, blockList: blockList)
            
        } catch {
            Log.fault("Failed to fetch Street: \(error)")
            return nil
        }
    }
}

// MARK: DBDay
extension PersistenceController {
    
    func saveDay(_ day: Day) {
        let context = PersistenceController.shared.container.viewContext
        
        let request: NSFetchRequest<DBDay> = DBDay.fetchRequest()
        request.predicate = NSPredicate(format: "uid == %@", day.uid)
        
        do {
            let result = try context.fetch(request)
            
            let dbDay: DBDay
            if let existingDay = result.first {
                dbDay = existingDay
            } else {
                dbDay = DBDay(context: context)
            }
            
            dbDay.uid = day.uid
            dbDay.title = day.title
            
            let newStreets = day.streetList.map { street -> DBStreet in
                let newStreet = DBStreet(context: context)
                newStreet.uid = street.uid
                newStreet.partType = street.partType.rawValue
                return newStreet
            }
            dbDay.streetList = NSOrderedSet(array: newStreets)
            
            try context.save()
            Log.info("Day saved successfully!")
        } catch {
            Log.error("Failed to save day: \(error)")
        }
    }
    
    func fetchDay(withUID uid: String) -> Day? {
        let context = PersistenceController.shared.container.viewContext
        
        let request: NSFetchRequest<DBDay> = DBDay.fetchRequest()
        request.predicate = NSPredicate(format: "uid == %@", uid)
        
        do {
            let result = try context.fetch(request)
            guard let dbDay = result.first else {
                return nil
            }
            
            guard let uid = dbDay.uid, let title = dbDay.title else {
                Log.fault("Missing uid or title in DBDay")
                return nil
            }
            
            let streetList: [Street] = (dbDay.streetList?.array as? [DBStreet])?.map { dbStreet in
                let partType = DayPartType(rawValue: dbStreet.partType) ?? .아침 // 기본값 설정
                return Street(uid: dbStreet.uid ?? "", partType: partType, blockList: [])
            } ?? []
            
            return Day(uid: uid, title: title, streetList: streetList)
            
        } catch {
            Log.fault("Failed to fetch Day: \(error)")
            return nil
        }
    }
}
