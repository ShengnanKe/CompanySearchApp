//
//  BookmarkModel.swift
//  CompanySearchApp
//
//  Created by KKNANXX on 7/16/24.
//

import Foundation
import Combine

class BookmarkModel: ObservableObject {
    @Published var bookmarkedCompanies: [Company] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
}
