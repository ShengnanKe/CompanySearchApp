//
//  DBManager.swift
//  CompanySearchApp
//
//  Created by KKNANXX on 7/16/24.
//

import Foundation
import CoreData

class DBManager {
    static let shared = DBManager()
    
    private init() {
        setupPersistentContainer()
    }
    
    private var persistentContainer: NSPersistentContainer!
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private func setupPersistentContainer() {
        persistentContainer = NSPersistentContainer(name: "CompanySearchApp") // 替换为你的数据模型名称
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
    }
    
    func addCompany(companyName: String, uuid: String, shortDescription: String) {
        let companyEntity = Company(context: context)
        companyEntity.name = companyName
        companyEntity.uuid = uuid
        companyEntity.descri = shortDescription
        saveContext()
    }

    func removeCompany(uuid: String) {
        let request: NSFetchRequest<Company> = Company.fetchRequest()
        request.predicate = NSPredicate(format: "uuid == %@", uuid)
        
        do {
            let companies = try context.fetch(request)
            for company in companies {
                context.delete(company)
            }
            saveContext()
        } catch {
            print("Unable to remove company: \(error)")
        }
    }
    
    func isCompanyBookmarked(uuid: String) -> Bool {
        let request: NSFetchRequest<Company> = Company.fetchRequest()
        request.predicate = NSPredicate(format: "uuid == %@", uuid)
        
        do {
            let count = try context.count(for: request)
            return count > 0
        } catch {
            print("Unable to check if company is bookmarked: \(error)")
            return false
        }
    }
    
    func fetchCompany() -> [Company] {
        let request: NSFetchRequest<Company> = Company.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("Unable to fetch company info: \(error)")
            return []
        }
    }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
