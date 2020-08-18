//
//  DataController.swift
//  Mooskine
//
//  Created by Khalid Aqeeli on 05/08/2020.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation
import CoreData

class DataController {
    
    let persistentContainer: NSPersistentContainer
     
    init(modelName:String) {
        self.persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func load(completion: (() -> Void)? = nil) {
        persistentContainer.loadPersistentStores { storeDescription, error in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
            self.autoSaveViewContext()
        completion?()
        }
    }
    
}

// autosave
extension DataController {
    // 30 is the default value xs
    func autoSaveViewContext(interval:TimeInterval = 30) {
        guard interval > 0 else { print("cannot set a nagitve number")
            return }
        print("autosaving")
        if viewContext.hasChanges {
            try? viewContext.save()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            self.autoSaveViewContext(interval: interval)
        }
    }
}
