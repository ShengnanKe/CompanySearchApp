//
//  Company+CoreDataProperties.swift
//  CompanySearchApp
//
//  Created by KKNANXX on 7/16/24.
//
//

import Foundation
import CoreData


extension Company {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Company> {
        return NSFetchRequest<Company>(entityName: "Company")
    }

    @NSManaged public var name: String?
    @NSManaged public var uuid: String?
    @NSManaged public var descri: String?

}

extension Company : Identifiable {

}
