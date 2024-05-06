//
//  APIServices+URL.swift
//
//  Created by Jai Ram Babu on 05/05/24.
//

import Foundation

protocol APIBaseServicesProtocol {
    var url: URL { get }
}

enum APIBaseUrl: APIBaseServicesProtocol {
    case base
    var url: URL {
        switch  self {
        case .base: return self.baseURL
                .appending(path: "api")
                .appending(path: "v2")
                .appending(path: "content")
                .appending(path: "misc")
                .appending(path: "media-coverages")
        }
    }
    private var baseURL : URL{
       return URL(string: "https://acharyaprashant.org")!
    }
}
