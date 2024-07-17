//
//  CompanyListView.swift
//  CompanySearchApp
//
//  Created by KKNANXX on 7/16/24.
//

// container.model.searchQuery


import SwiftUI

struct CompanyListView: View {
    @StateObject private var container: MVIContainer<CompanyListIntent, CompanyListModel>
    @State private var selectedCompany: CompanyDetails?
    
    init(company: String){
        let model = CompanyListModel(searchQuery: company)
        let intent = CompanyListIntent(model: model)
        _container = StateObject(wrappedValue: MVIContainer(intent: intent, model: model, modelChangePublisher: model.objectWillChange))
    }
    var body: some View {
        List(container.model.searchResult, id:\.uuid){ company in
            NavigationLink(
                destination: CompanyDetailsView(company: company),
                tag: company,
                selection: $selectedCompany
            ){
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/){
                    Text(company.value ?? "placeholder")
                    Text(company.uuid ?? "Placeholder")
                    Text(company.entityID ?? "Placeholder")
                }
            }
        }
        .navigationTitle("company list")
        .onAppear{
            container.intent.fetchCompanyList()
        }
    }
}


