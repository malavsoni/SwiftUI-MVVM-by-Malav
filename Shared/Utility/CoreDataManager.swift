//
//  CoreDataManager.swift
//  SwiftUI-MVVM-Sample
//
//  Created by Malav Soni on 16/08/20.
//

import Foundation
import CoreData

class CoreDataManager: NSObject {

    static let shared:CoreDataManager = CoreDataManager()

    // Get the location where the core data DB is stored

    lazy var applicationDocumentsDirectory: URL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named in the application's documents Application Support directory.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(urls[urls.count-1])
        return urls[urls.count-1]
    }()

    func applicationLibraryDirectory() {
        print(applicationDocumentsDirectory)
        if let url = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).last {
            print(url.absoluteString)
        }
    }

    // MARK: - Core Data stack
    lazy var managedObjectContext = {
        return self.persistentContainer.viewContext
    }()

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "SwiftUI-MVVM-Sample")
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
                fatalError("Unresolved error \(error), \(error.userInfo), \(storeDescription)")
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

    // Save Data in background
    func saveDataInBackground() {

        persistentContainer.performBackgroundTask { (context) in

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
    }
}

extension CoreDataManager {

    @discardableResult
    func removeAllLocationInfo() -> Bool {
        let request:NSFetchRequest<MSLocation> = MSLocation.fetchRequest()
        do {
            let locations =  try self.managedObjectContext.fetch(request)
            for location in locations {
                self.managedObjectContext.delete(location)
            }
            self.saveContext()
            return true
        } catch {
        }
        return false
    }

    @discardableResult
    func fetchLastLocationInfo() -> Result<MSLocation,Error> {
        let request:NSFetchRequest<MSLocation> = MSLocation.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor.init(keyPath: \MSLocation.date, ascending: false)]
        request.fetchLimit = 1
        request.relationshipKeyPathsForPrefetching = [#keyPath(MSLocation.weatherInfo)]
        do {
            if let location:MSLocation = try self.managedObjectContext.fetch(request).first {
                return .success(location)
            } else {
                return .failure(MTCoreDataError.noDataAvailable)
            }
        } catch {
        //Optional(2020-05-16 21:12:15 +0000)
        }
        return .failure(MTCoreDataError.noDataAvailable)
    }
}

extension NSManagedObject {
    public func save() {
        CoreDataManager.shared.saveContext()
    }
}
