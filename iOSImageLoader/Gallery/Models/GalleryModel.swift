//
//  GalleryModel.swift
//  iOSImageLoader
//
//  Created by Jai Ram Babu on 05/05/24.
//

import Foundation
import UIKit


// MARK: Request - Query params
extension Gallery {
    
    struct GalleryListQueryParam: Encodable {
        let limit: String
        enum CodingKeys: String, CodingKey{
            case limit = "limit"
        }
        
        init(limit: String) {
            self.limit = limit
        }
    }
}


// MARK:  - Response
extension Gallery {
    
    class GalleryModel: Decodable, Identifiable, ObservableObject {
        let id, title: String
        let language: Language
        let mediaType: Int
        let publishedAt, publishedBy: String
        let backupDetails: GalleryModelBackupDetails?
        let coverageURL: String
        let thumbnail: GalleryThumbnail?
        @MainActor @Published var downloadedURL : URL?
        var dataTask: URLSessionDataTask?
        
        init(id: String, title: String, language: Language, mediaType: Int, publishedAt: String, publishedBy: String, backupDetails: GalleryModelBackupDetails?, coverageURL: String, thumbnail: GalleryThumbnail?) {
            self.id = id
            self.title = title
            self.language = language
            self.mediaType = mediaType
            self.publishedAt = publishedAt
            self.publishedBy = publishedBy
            self.backupDetails = backupDetails
            self.coverageURL = coverageURL
            self.thumbnail = thumbnail
        }
        
        enum CodingKeys: String, CodingKey {
            case id = "id"
            case title = "title"
            case language = "language"
            case mediaType = "mediaType"
            case publishedAt = "publishedAt"
            case publishedBy = "publishedBy"
            case backupDetails = "backupDetails"
            case coverageURL = "coverageURL"
            case thumbnail = "thumbnail"
        }
        
        required init(from decoder: any Decoder) throws {
            let container: KeyedDecodingContainer<Gallery.GalleryModel.CodingKeys> = try decoder.container(keyedBy: Gallery.GalleryModel.CodingKeys.self)
            self.id = try container.decode(String.self, forKey: Gallery.GalleryModel.CodingKeys.id)
            self.title = try container.decode(String.self, forKey: Gallery.GalleryModel.CodingKeys.title)
            self.language = try container.decode(Gallery.Language.self, forKey: Gallery.GalleryModel.CodingKeys.language)
            self.mediaType = try container.decode(Int.self, forKey: Gallery.GalleryModel.CodingKeys.mediaType)
            self.publishedAt = try container.decode(String.self, forKey: Gallery.GalleryModel.CodingKeys.publishedAt)
            self.publishedBy = try container.decode(String.self, forKey: Gallery.GalleryModel.CodingKeys.publishedBy)
            self.backupDetails = try container.decodeIfPresent(Gallery.GalleryModelBackupDetails.self, forKey: Gallery.GalleryModel.CodingKeys.backupDetails)
            self.coverageURL =  try container.decode(String.self, forKey: Gallery.GalleryModel.CodingKeys.coverageURL)
            self.thumbnail = try container.decode(GalleryThumbnail.self, forKey: Gallery.GalleryModel.CodingKeys.thumbnail)
            
        }
        
        deinit {
            print("GalleryModel deinit")
        }
    }
    
    // MARK: - GalleryModelBackupDetails
    struct GalleryModelBackupDetails: Decodable {
        let pdfLink: String
        let screenshotURL: String
    }

    // MARK: - Thumbnail
    struct GalleryThumbnail: Codable {
        let id: String
        let version: Int
        let domain: String
        let basePath: String
        let key: String
      
        enum CodingKeys: String, CodingKey {
            case id = "id"
            case version = "version"
            case domain = "domain"
            case basePath = "basePath"
            case key = "key"
        }
    }
    
    enum Language: String, Codable {
        case english = "english"
        case hindi = "hindi"
    }
}



