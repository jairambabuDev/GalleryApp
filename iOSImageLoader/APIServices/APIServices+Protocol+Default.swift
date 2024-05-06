//
//  APIServices+Protocol+Default.swift
//  iOSImageLoader
//
//  Created by Jai Ram Babu on 05/05/24.
//

import Foundation

extension APIServicesProtocol {
    
    /// queryParamsBase
    /// - Parameter queryParams:
    /// - Returns: String
    static func queryParamsBase<T>(_ queryParams: T?) -> String {
        var dicHeaders = [String: String]()
        if let params = queryParams as? Encodable{
            if let response = params.dictionary() as? [String: Any] {
                response.forEach { (key, value) in
                    dicHeaders[key] = "\(value)"
                }
            }
        } else if let headers = queryParams as? [String: Any] {
            headers.forEach { (key, value) in
                dicHeaders[key] = "\(value)"
            }
        }
       return self.generateQueryURLWith(url: self.url, urlParameters: dicHeaders)
    }
}

extension APIServicesProtocol {
    /// generateQueryURLWith
    /// - Parameters:
    ///   - url: URL
    ///   - urlParameters: [String: String]
    /// - Returns: String
    static func generateQueryURLWith(url: URL, urlParameters: [String: String]?) -> String {
        let urlComponents = NSURLComponents(url: url, resolvingAgainstBaseURL: false)
        guard let component = urlComponents else {
            return url.absoluteString
        }
        if let params = urlParameters {
            component.queryItems = params.map({ (key, value) -> URLQueryItem in
                return URLQueryItem(name: key, value: value)
            })
        }
       return component.url?.absoluteString ?? url.absoluteString
    }
}
