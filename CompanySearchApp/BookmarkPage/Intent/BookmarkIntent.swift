//
//  BookmarkIntent.swift
//  CompanySearchApp
//
//  Created by KKNANXX on 7/16/24.
//

import Foundation
import Combine

class BookmarkIntent: ObservableObject {
    @Published private var model: BookmarkModel
    private var cancellables = Set<AnyCancellable>()
    
    init(model: BookmarkModel) {
        self.model = model
    }
    
    func loadBookmarks() {
        model.isLoading = true
        DispatchQueue.global(qos: .userInitiated).async {
            let companies = DBManager.shared.fetchCompany()
            DispatchQueue.main.async {
                self.model.bookmarkedCompanies = companies
                self.model.isLoading = false
            }
        }
    }
}
