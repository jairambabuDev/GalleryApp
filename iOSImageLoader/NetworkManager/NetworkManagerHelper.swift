//
//  NetworkManagerHelper.swift
//  iOSImageLoader
//
//  Created by Jai Ram Babu on 05/05/24.
//

import Foundation
import Combine

// MARK:  Network Manager

// MARK:  APIHelper
class NetworkManagerHelper {
    static let shared = NetworkManagerHelper()

    func fetch<T: Decodable>(responseType: T.Type,
                             url: String,
                             completion: @escaping (Result<T, NetworkManagerHelper.APIStatusError>) -> Void) {
        
        guard let url = URL(string: url) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            let result : Result<T, NetworkManagerHelper.APIStatusError>
            
            defer{
                completion(result)
            }
            
            if let error = error {
                result = .failure(.error(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                result = .failure(.invalidStatus)
                return
            }
            
            guard let data = data else {
                result = .failure(.invalidData)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let myData = try decoder.decode(responseType.self, from: data)
                result = .success(myData)
            } catch {
                result = .failure(.error(error))
            }
        }
        task.resume()
    }
}

// MARK: Download Image
extension NetworkManagerHelper {
    
    /// downloadImageServer
    /// - Parameters:
    ///   - remoteURL: URL
    ///   - downloadedPath: URL?
    ///   - completion: Result
    /// - Returns: URLSessionDataTask?
    func downloadImageServer(remoteURL: URL, downloadedPath: URL?, completion: @escaping(Result<Data, NetworkManagerHelper.APIStatusError>) -> Void) -> URLSessionDataTask?{
        
        return URLSession.shared.dataTask(with: remoteURL) { data, response, error in
            
            var result : Result<Data,NetworkManagerHelper.APIStatusError>
            defer {
                completion(result)
            }
            guard let data , error == nil  else {
                result = .failure(.error(error))
                return
            }
            result = .success(data)
        }
    }
}
// MARK: Error Handle
extension NetworkManagerHelper {
    enum APIStatusError: Error{
        case invalidSelf
        case invalidStatus
        case invalidData
        case invalidDecode
        case invalidDownloadedURL
        case error(Error?)
    }
}
