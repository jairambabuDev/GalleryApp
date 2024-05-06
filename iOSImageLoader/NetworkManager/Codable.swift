//
//  Codable.swift
//  iOSImageLoader
//
//  Created by Jai Ram Babu on 05/05/24.
//

import Foundation

extension Encodable {
    
    func dictionary() -> Any? {
        do{
            guard let data = try? JSONEncoder().encode(self) else { return nil }
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            return json
        } catch {
            print("\(error)")
            return nil
        }
    }
    
    func encode() -> Data?{
        do {
            let data = try JSONEncoder().encode(self)
            return data
        } catch {
            print("\(error)")
            return nil
        }
    }
}

extension Decodable {
    
    func decode<T: Codable>(_ data: Data) -> T? {
        do {
            let model =  try JSONDecoder().decode(T.self , from: data)
            return model
        } catch {
            print("\(error)")
            return  nil
        }
    }
    
}
