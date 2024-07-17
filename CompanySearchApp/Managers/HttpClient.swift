//
//  HttpClient.swift
//  CompanySearchApp
//
//  Created by KKNANXX on 7/16/24.
//

import Foundation
import SwiftUI
import Combine

enum AppError: Error{
    
    case badResponse
    case badURL
    case badData
    case decoderError
    
}

enum HTTPMethod: String{
    case get = "GET"
}

protocol RequestBuilder{
    var baseUrl: String{ get }
    var path: String? { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var queryParam:[String: String]? { get }
}

extension RequestBuilder{
    func buildRequest() throws -> URLRequest{
        guard var urlComponents = URLComponents(string: baseUrl) else{
            throw AppError.badURL
        }
        
        if let path = path {
            urlComponents.path = urlComponents.path.appending(path)
        }
        
        if let queryParam = queryParam {
            let encodeQuery = encodeParam(queryParam)
            urlComponents.query = encodeQuery
        }
        
        guard let url = urlComponents.url else {
            throw AppError.badURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let headers = headers {
            for (key, value) in headers{
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        return request
        
    }
    
    private func encodeParam(_ params:[String:String]) -> String? {
        var components = URLComponents()
        components.queryItems = params.map { URLQueryItem(name: $0 , value: $1)}
        return components.percentEncodedQuery
    }
    
}

class HttpClient{
    func fetchData<T:Decodable> (from requestBuilder: RequestBuilder) -> AnyPublisher<T,Error>{
        do{
            let request = try requestBuilder.buildRequest()
            return URLSession.shared.dataTaskPublisher(for: request)
                .tryMap{ data, response in
                    guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                        throw URLError(.badServerResponse)
                    }
                    return data
                }
                .decode(type: T.self, decoder: JSONDecoder())
                .eraseToAnyPublisher()
        }
        catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
    
}
