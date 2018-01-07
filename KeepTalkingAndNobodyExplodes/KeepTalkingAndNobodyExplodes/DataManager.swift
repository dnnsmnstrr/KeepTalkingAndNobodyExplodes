//
//  DataManager.swift
//  KeepTalkingAndNobodyExplodes
//
//  Created by Salomé Russier on 07/01/2018.
//  Copyright © 2018 Salomé Russier. All rights reserved.
//

import Foundation
import CoreData

class DataManager {
    // singleton
    public static let shared = DataManager()
    
    public var objectContext: NSManagedObjectContext? = nil
    
    private init() {
        if let modelURL = Bundle.main.url(forResource: "Model", withExtension: "momd") {
            if let model = NSManagedObjectModel(contentsOf: modelURL) {
                if let storageURL = FileManager.documentURL(childPath: "MyDatabase.db") {
                    //print(storageURL)
                    let storeCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
                    _ = try? storeCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storageURL, options: nil)
                    
                    let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
                    context.persistentStoreCoordinator = storeCoordinator
                    self.objectContext = context
                }
            }
        }
    }
    
}
