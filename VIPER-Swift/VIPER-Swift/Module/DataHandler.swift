//
//  DataHandler.swift
//  VIPER-Swift
//
//  Created by 강희선 on 2022/11/03.
//

import Foundation
import CoreData

protocol DataHandler {
    associatedtype Data
    func get() -> Data
    func save(_ data: Data)
}

class CoreDataStack {
    private var modelName: String
    
    lazy var storeContaienr: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName)
        
        container.loadPersistentStores { description, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        
        return container
    }()
    
    lazy var managedContext: NSManagedObjectContext = {
        storeContaienr.viewContext
    }()

    init(modelName: String) {
        self.modelName = modelName
    }
    
    func fetchData<R: NSFetchRequestResult>(_ request: NSFetchRequest<R>) -> [R] {
        do {
            let result = try managedContext.fetch(request)
            return result
        } catch let error {
            print(error)
        }
                
        return []
    }
    
    func saveContext() {
        guard managedContext.hasChanges else { return }
        
        do {
            
        } catch let error as NSError {
            
        }
    }
}
