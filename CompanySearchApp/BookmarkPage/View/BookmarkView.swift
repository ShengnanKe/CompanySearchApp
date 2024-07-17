//
//  BookmarkView.swift
//  CompanySearchApp
//
//  Created by KKNANXX on 7/16/24.
//

import SwiftUI

struct BookmarkView: View {
    @StateObject private var container: MVIContainer<BookmarkIntent, BookmarkModel>
    
    init() {
        let model = BookmarkModel()
        let intent = BookmarkIntent(model: model)
        _container = StateObject(wrappedValue: MVIContainer(intent: intent, model: model, modelChangePublisher: model.objectWillChange))
    }
    
    var body: some View {
        NavigationView {
            List(container.model.bookmarkedCompanies, id: \.self) { company in
                NavigationLink(destination: CompanyDetailsView(company: CompanyDetails(uuid: company.uuid, value: company.name, entityID: "N/A"))) {
                    VStack(alignment: .leading) {
                        Text(company.name ?? "Unknown Company")
                            .font(.headline)
                        Text(company.descri ?? "No description available")
                            .font(.subheadline)
                    }
                }
            }
            .navigationTitle("Bookmarked Companies")
            .onAppear {
                container.intent.loadBookmarks()
            }
        }
    }
}
