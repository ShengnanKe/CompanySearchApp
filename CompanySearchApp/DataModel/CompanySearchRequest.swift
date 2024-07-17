//
//  CompanySearchRequest.swift
//  CompanySearchApp
//
//  Created by KKNANXX on 7/16/24.
//
/*
 curl --request GET \
 --url 'https://crunchbase-crunchbase-v1.p.rapidapi.com/autocompletes?query=UBS' \
 --header 'x-rapidapi-host: crunchbase-crunchbase-v1.p.rapidapi.com' \
 --header 'x-rapidapi-key: cf4863382emsh660b0a010bd400dp1de074jsn26d3499ba6e2'
 */
import Foundation

struct CompanySearchRequest: RequestBuilder{
    
    let company: String
    
    var baseUrl: String{
        "https://crunchbase-crunchbase-v1.p.rapidapi.com"
    }
    
    var path: String? {
        "/autocompletes"
    }
    var method: HTTPMethod {
        .get
    }
    var headers: [String: String]? {
        [
            "x-rapidapi-host": "crunchbase-crunchbase-v1.p.rapidapi.com",
            "x-rapidapi-key": "cf4863382emsh660b0a010bd400dp1de074jsn26d3499ba6e2"
            
        ]
    }
    
    var queryParam: [String: String]? {
        ["query": company]
    }
    
    
}
