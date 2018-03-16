//
//  CoreData.swift
//  JSONParsingAlmofire
//
//  Created by iOS2 on 18/04/17.
//  Copyright © 2017 iOS2. All rights reserved.
//

import UIKit
import CoreData


class CoreData: NSObject
{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func getContextPersistent() -> NSManagedObjectContext
    {
        return appDelegate.persistentContainer.viewContext
    }
    
    func saveLoinData(dictionary : NSMutableDictionary) -> Void
    {
        let login = LoginData(context: getContextPersistent())
        login.name = dictionary.value(forKey: "name" ) as! String?
        login.email = dictionary.value(forKey: "email" ) as! String?
        login.contactnumber = dictionary.value(forKey: "contact" ) as! String?
        
        appDelegate.saveContext()
    }
    
    func getProductDetails(entityName : String) -> [Any]
    {
        let context : NSManagedObjectContext = getContextPersistent()
        let entity1 = NSEntityDescription.entity(forEntityName: entityName, in: context)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        fetchRequest.entity = entity1
        let result: [Any]? = try? context.fetch(fetchRequest)
        // NSLog(@"resutl : %@",result);
        return result!
    }
    
    func existingDataCheck(fromTable table: String, conditions: String, orderBycolumn: String, ascending asc: Bool) -> [Any]
    {
        let context: NSManagedObjectContext = getContextPersistent()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        let entity = NSEntityDescription.entity(forEntityName: table, in: context)
        fetchRequest.entity = entity
        if conditions != "" {
          //  print(" condition-->\(conditions)")
            let predicate = NSPredicate(format: conditions)
            fetchRequest.predicate = predicate
        }
        if orderBycolumn != "" {
            let sortDescriptor = NSSortDescriptor(key: orderBycolumn, ascending: asc)
            fetchRequest.sortDescriptors = [sortDescriptor]
        }
        var result : NSArray! 
        
        do
        {
            result =  try? context.fetch(fetchRequest) as NSArray!
            //print(try! context.fetch(fetchRequest))
        }
        catch let error as NSError
        {
           // let fetcherr = error as NSError
            print("Error \(error.localizedDescription)")
        }
        
        return result! as! [Any]
    }
    
    func makeDataBaseEntry(dictionary : NSMutableDictionary) -> Bool
    {
        let context: NSManagedObjectContext = getContextPersistent()
        let entity1 = NSEntityDescription.insertNewObject(forEntityName: "LoginData", into: context) as! LoginData
        entity1.name = dictionary.value(forKey: "name" ) as! String?
        entity1.email = dictionary.value(forKey: "email" ) as! String?
        
        var val  = Bool()
        
        if context.hasChanges
        {
            do
            {
                try context.save()
                
                val = true
            }
            catch
            {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                val = false
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
        
        return val
    }
    
    func deleteAllRowsFromDataBaseTable(tableName: String)
    {
        let context: NSManagedObjectContext = getContextPersistent()
        let entity1 = NSEntityDescription.entity(forEntityName: tableName, in: context)
        let fetch = NSFetchRequest<NSFetchRequestResult>()
        fetch.entity = entity1
       
        let fetchedProducts: [Any]? = try? context.fetch(fetch)
        
        for product in fetchedProducts!
        {
            context.delete(product as! NSManagedObject)
        }
        
        do
        {
            try context.save()
        }
        catch
        {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    func deleteRowFromDataBase(tableName: String, andKeys keys: String) -> Bool
    {
        let context: NSManagedObjectContext = getContextPersistent()
        let entity1 = NSEntityDescription.entity(forEntityName: tableName, in: context)
        let fetch = NSFetchRequest<NSFetchRequestResult>()
        fetch.entity = entity1
        let pred = NSPredicate(format: keys)
        fetch.predicate = pred
        let fetchedProducts: [Any]? = try? context.fetch(fetch)
        
        for product in fetchedProducts!
        {
            context.delete(product as! NSManagedObject)
        }
        
        var val  = Bool()
        
        do
        {
            try context.save()
            val = true
        }
        catch
        {

            val = false
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return val
    }
    
    
}



