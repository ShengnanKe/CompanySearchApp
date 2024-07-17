//
//  CompanyListIntent.swift
//  CompanySearchApp
//
//  Created by KKNANXX on 7/16/24.
//

import Foundation
import Combine

class CompanyListIntent: ObservableObject {
    @Published private var model: CompanyListModel
    private var cancellables = Set<AnyCancellable>()
    
    init(model: CompanyListModel) {
        self.model = model
    }
    
    func fetchCompanyList() {
        guard !model.isLoading else { return }
        
        model.isLoading = true
        model.errorMessage = nil
        
        let request = CompanySearchRequest(company: model.searchQuery)
        
        HttpClient().fetchData(from: request)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.model.errorMessage = error.localizedDescription
                    self.model.isLoading = false
                    print("Error: \(error.localizedDescription)")
                case .finished:
                    break
                }
            } receiveValue: { (companysInfo: CompanysInfo) in
                self.model.searchResult = companysInfo.entities.map { $0.identifier }
                self.model.isLoading = false
            }
            .store(in: &cancellables)
    }
}
