//
//  CoreDataManager.swift
//  TodoListApp
//
//  Created by Wejdan Alkhaldi on 01/04/1443 AH.
//

import Foundation
import CoreData

class CoreDataManager  {
    
    let persistentContainer: NSPersistentContainer
    static let shared: CoreDataManager = CoreDataManager()
    
    private init() {
        
        persistentContainer = NSPersistentContainer(name: "TodoDatabase")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to initialize Core Data \(error)")
            }
        }
    }
}
