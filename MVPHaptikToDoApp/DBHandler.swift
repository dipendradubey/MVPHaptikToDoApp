//
//  DBHandler.swift
//  MVPHaptikToDoApp
//
//  Created by Dipendra Dubey on 02/02/20.
//  Copyright © 2020 Dipendra. All rights reserved.
//

import Foundation
import CoreData

class DBHandler{
    // MARK: - Core Data stack
    
    static let sharedManager = DBHandler()
    private init(){}
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "TODO")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
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
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    lazy var sortDescriptor: [NSSortDescriptor] = {
        let sectionSortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        return [sectionSortDescriptor]
    }()
    
    func fetchToDo(_ predicate: NSPredicate)->[ToDo]{
        var arrToDo  = [ToDo]() // Where Locations = your NSManaged Class
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDo")
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptor
        do{
            arrToDo = try persistentContainer.viewContext.fetch(fetchRequest) as! [ToDo]
        }
        catch (let error){
            print(error.localizedDescription)
        }
       
        return arrToDo
    }

}
