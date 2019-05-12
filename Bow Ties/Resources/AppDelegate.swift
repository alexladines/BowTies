//  AppDelegate.swift
//  Bow Ties
//
//  Created by Alex Ladines on 5/10/19.
//  Copyright © 2019 Alex Ladines. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    guard let vc = window?.rootViewController as? BowTiesViewController else {
      return true
    }
    
    vc.managedContext = persistentContainer.viewContext
    
    return true
//    // Save test entity
//    let bowtie = NSEntityDescription.insertNewObject(forEntityName: "BowTie", into: self.persistentContainer.viewContext) as! BowTie
//    bowtie.name = "My bow tie."
//    bowtie.lastWorn = NSDate()
//    saveContext()
//
//    // Retrieve test bow tie
//    let request: NSFetchRequest<BowTie> = BowTie.fetchRequest()
//
//    if let ties =
//    try? self.persistentContainer.viewContext.fetch(request),
//    let testName = ties.first?.name,
//      let testLastWorn = ties.first?.lastWorn {
//      print("Name: \(testName), Worn: \(testLastWorn)")
//    }
//    else {
//        print("Test Failed.")
//    }
//    return true
  }

  func applicationWillTerminate(_ application: UIApplication) {
    self.saveContext()
  }

  // MARK: - Core Data stack
  lazy var persistentContainer: NSPersistentContainer = {
    //  The persistent container for the application. This implementation
    //  creates and returns a container, having loaded the store for the
    //  application to it. This property is optional since there are legitimate
    //  error conditions that could cause the creation of the store to fail.
    let container = NSPersistentContainer(name: "Bow_Ties")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        // Replace this implementation with code to handle the error appropriately.
        // fatalError() causes the application to generate a crash log and terminate.
        // You should not use this function in a shipping application, although it may be useful during development.

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
        // fatalError() causes the application to generate a crash log and terminate.
        // You should not use this function in a shipping application, although it may be useful during development.
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
}
