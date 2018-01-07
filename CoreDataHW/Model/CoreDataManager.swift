//
//  CoreDataManager.swift
//  CoreDataHW
//
//  Created by Vadim Shoshin on 06.01.2018.
//  Copyright © 2018 Vadim Shoshin. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataManager {
    static let instance = CoreDataManager()
    private init() { }
    
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "CoreDataHW")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
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
