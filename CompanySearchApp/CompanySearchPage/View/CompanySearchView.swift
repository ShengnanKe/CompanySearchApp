//
//  CompanySearchView.swift
//  CompanySearchApp
//
//  Created by KKNANXX on 7/16/24.
//

import SwiftUI

struct CompanySearchView: View {
    @StateObject private var container: MVIContainer<CompanySearchIntent, CompanySearchModel>
    @State private var isSearching = false
    
    init() {
        let model = CompanySearchModel()
        let intent = CompanySearchIntent(model: model)
        _container = StateObject(wrappedValue: MVIContainer(intent: intent, model: model, modelChangePublisher: model.objectWillChange))
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    TextField("search company...", text: $container.model.searchQuery)
                    Button(action: {
                        isSearching = true
                    }) {
                        Text("search") // button text
                    }
                }
                .padding()
                
                NavigationLink(
                    destination: CompanyListView(company: container.model.searchQuery),
                    isActive: $isSearching
                ){
                    EmptyView()
                }
            }
            .navigationTitle("Company search Page")
            
        }
    }
}


//
//#Preview {
//    CompanySearchView()
//}
