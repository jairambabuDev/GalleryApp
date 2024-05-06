//
//  APIService.swift
//  iOSImageLoader
//
//  Created by Jai Ram Babu on 05/05/24.
//

import Foundation


extension APIServices {
    enum GalleryService: APIServicesProtocol {
        
        static var url: URL{
            
            return APIBaseUrl.base.url
            
        }
        static func queryParams<T>(_ queryParams: T?) -> String {
            
           return self.queryParamsBase(queryParams)
        }
        
        static func headers<T>(_ headers: T?) -> [String : Any]? {
            return nil
        }
        
        static func parameters<T>(_ params: T?) -> [String : Any]? {
            return nil
        }
        
    }

}
