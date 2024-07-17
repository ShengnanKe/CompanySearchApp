//
//  CompanyListModel.swift
//  CompanySearchApp
//
//  Created by KKNANXX on 7/16/24.
//

import Foundation

class CompanyListModel: ObservableObject {
    @Published var searchResult: [CompanyDetails] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    let searchQuery: String
    
    init(searchQuery: String) {
        self.searchQuery = searchQuery
    }
}
