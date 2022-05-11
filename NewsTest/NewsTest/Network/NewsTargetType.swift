//
//  NewsTargetType.swift
//  NewsTest
//
//  Created by AnhLe on 10/05/2022.
//

import Foundation
import Moya

enum NewsTargetType {
    case home(page: Int)
    case search(keyword: String, page: Int)
}

extension NewsTargetType: TargetType {
    
    static let baseURL = "https://newsapi.org/v2"
    static let apiKey = "cbf6678a44734108bfef6a6a27e4d0b0"
    static let pageSize = 10
    
    var baseURL: URL {
        return URL(string: NewsTargetType.baseURL)!
    }
    
    var path: String {
        return "/everything"
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .home:
            return .requestParameters(parameters: parameters, encoding: parameterEncoding)
        case .search:
            return .requestParameters(parameters: parameters, encoding: parameterEncoding)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var parameters: [String: Any] {
        var params: [String: Any] = [:]
        
        switch self {
        case .home(let page):
            params = ["apiKey": NewsTargetType.apiKey,
                    "pageSize": NewsTargetType.pageSize,
                    "sources": "reuters",
                    "page": page]
        case .search(let keywords, let page):
            params = ["apiKey": NewsTargetType.apiKey,
                    "pageSize": NewsTargetType.pageSize,
                    "page": page,
                    "sources": "reuters",
                    "q": keywords]
        }
        return params
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
}
