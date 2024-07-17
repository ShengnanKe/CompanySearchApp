//
//  HomePage.swift
//  CompanySearchApp
//
//  Created by KKNANXX on 7/16/24.
//

import SwiftUI

struct HomePage: View {
    var body: some View {
        TabView{
            CompanySearchView()
                .tabItem{
                    Text("CompanySearch")
                }
            
            BookmarkView()
                .tabItem{
                    Text("Bookmark")
                    Image(systemName: "star")
                }
        }
    }
}

#Preview {
    HomePage()
}
