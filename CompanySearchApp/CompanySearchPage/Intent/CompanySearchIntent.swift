//
//  CompanySearchIntent.swift
//  CompanySearchApp
//
//  Created by KKNANXX on 7/16/24.
//

import Foundation

class CompanySearchIntent: ObservableObject{
    
    @Published private var model: CompanySearchModel
    
    init(model: CompanySearchModel) {
        self.model = model
    }
}
