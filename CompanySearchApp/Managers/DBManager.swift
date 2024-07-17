//
//  DBManager.swift
//  CompanySearchApp
//
//  Created by KKNANXX on 7/16/24.
//

import Foundation
import CoreData

class DBManager{
    static let shared = DBManager()
    
    private init(){}
    
    var context: NSManagedObjectContext!
    
    func setContext(_ context: NSManagedObjectContext){
        self.context = context
    }
    
    func addCompany(companyName: String, uuid: String, shortDescription: String){
        let companyEntity = Company(context: context)
        companyEntity.name = companyName
        companyEntity.uuid = uuid
        companyEntity.descri = shortDescription
        saveContext()
    }
    
    func fetchCompany() -> [Company]{
        guard let context = context else{
            return []
        }
        
        let request: NSFetchRequest<Company> = Company.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("unable to fetch company info")
            return []
        }
    }
    
    func saveContext(){
        if context.hasChanges{
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("got error \(nsError)")
            }
        }
    }
}
