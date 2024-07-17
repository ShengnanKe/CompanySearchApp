//
//  CompanyDetailsView.swift
//  CompanySearchApp
//
//  Created by KKNANXX on 7/16/24.
//

import SwiftUI

struct CompanyDetailsView: View {
    let company: CompanyDetails
    @State private var isBookmarked: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Company Name: \(company.value ?? "N/A")")
                .font(.headline)
            
            Text("UUID: \(company.uuid ?? "N/A")")
                .font(.subheadline)
            
            Text("Entity ID: \(company.entityID ?? "N/A")")
                .font(.subheadline)
            
            Button(action: {
                toggleBookmark()
            }) {
                Text(isBookmarked ? "Remove Bookmark" : "Add to Bookmarks")
                    .padding()
                    .background(isBookmarked ? Color.red : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
        .navigationTitle(company.value ?? "Company Details")
        .onAppear {
            checkIfBookmarked()
        }
    }
    
    private func toggleBookmark() {
        if isBookmarked {
            removeBookmark()
        } else {
            addBookmark()
        }
    }

    private func addBookmark() {
        DBManager.shared.addCompany(companyName: company.value ?? "", uuid: company.uuid ?? "", shortDescription: company.entityID ?? "")
        isBookmarked = true
    }

    private func removeBookmark() {
        DBManager.shared.removeCompany(uuid: company.uuid ?? "")
        isBookmarked = false
    }

    private func checkIfBookmarked() {
        isBookmarked = DBManager.shared.isCompanyBookmarked(uuid: company.uuid ?? "")
    }
}
