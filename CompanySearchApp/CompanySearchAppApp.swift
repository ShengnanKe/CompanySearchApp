//
//  CompanySearchAppApp.swift
//  CompanySearchApp
//
//  Created by KKNANXX on 7/16/24.
//

import SwiftUI

@main
struct CompanySearchAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomePage()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
