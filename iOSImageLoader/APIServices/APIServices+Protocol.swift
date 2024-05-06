//
//  APIServices+Protocol.swift
//  iOSImageLoader
//
//  Created by Jai Ram Babu on 05/05/24.
//

import Foundation

enum APIServices {
}

// MARK: APIServicesProtocol services Call Rules
protocol APIServicesProtocol {
    static var  url: URL { get }
    static func queryParams<T>(_ queryParams: T?) -> String
    static func headers<T>(_ headers: T?) -> [String: Any]?
    static func parameters<T>(_ params: T?) -> [String: Any]?
}


