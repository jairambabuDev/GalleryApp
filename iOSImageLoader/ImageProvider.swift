//
//  ImageProvider.swift
//
//
//  Created by Jai Ram Babu on 05/05/24.
//

import Foundation
import UIKit

class ImageProvider {
    
    static let shared = ImageProvider()
    private var imageCache : NSCache<NSString, NSURL>  = {
        let imageCache = NSCache<NSString, NSURL>()
        imageCache.countLimit = 70
        imageCache.totalCostLimit = 1024 * 1024 * 200 // 200mb
        return imageCache
    }()
    
    private init(){ }
    
    
    /// image
    /// - Parameters:
    ///   - id: String
    ///   - remoteURL: URL
    ///   - completion: URL?
    /// - Returns: URLSessionDataTask?
    func image(id:String, remoteURL: URL, completion:@escaping(URL?) -> Void) -> URLSessionDataTask?{
        
        if let image = self.imageCache.object(forKey: remoteURL.path as NSString){
            print("Getting image from cache memory")
            completion(image as URL)
        } else {
            let  downloadedPath = getDownloadImagePath(id, url: remoteURL)
            
            if let downloadedPath, FileManager.default.fileExists(atPath: downloadedPath.path){
                self.imageCache.setObject(downloadedPath as NSURL, forKey: remoteURL.path as NSString)
                print("Getting image from cache directory")
                completion(downloadedPath)
            } else {
                
               return downloadFromServer(remoteURL: remoteURL, downloadedPath: downloadedPath) { downloadedPathTemp in
                   print("Getting image from Sever")
                    completion(downloadedPathTemp)
                }
            }
        }
        return nil
    }
    
}
extension ImageProvider{
    
    /// downloadFromServer
    /// - Parameters:
    ///   - remoteURL: URL
    ///   - downloadedPath: URL?
    ///   - completion: URL?
    /// - Returns: URLSessionDataTask?
    fileprivate func downloadFromServer(remoteURL: URL, downloadedPath:URL?, completion:@escaping(URL?) -> Void) -> URLSessionDataTask?{
        
        return NetworkManagerHelper.shared.downloadImageServer(remoteURL: remoteURL, downloadedPath: downloadedPath) { [weak self] result in
            switch result{
            case .success(let data):
                
                guard let downloadedPath else {
                    return
                }
                do {
                    
                    let data = UIImage(data: data)?.jpegData(compressionQuality: 0.8)
                    try  data?.write(to: downloadedPath)
                    self?.imageCache.setObject(downloadedPath as NSURL , forKey: remoteURL.path as NSString)
                    completion(downloadedPath)
                }catch {
                    completion(nil)
                }
                
            case .failure( _ ):
                completion(nil)
            }
        }
      }
    
    /// getDownloadImagePath
    /// - Parameters:
    ///   - itemID: String
    ///   - url: URL
    /// - Returns: URL?
    fileprivate func getDownloadImagePath(_ itemID: String, url:URL) -> URL?{
        
        let downloadPathDirectory = self.getCacheDirectoryURL(itemID)
        guard let nameWithURL = getPathWith(fileName: String(url.lastPathComponent.split(separator: ".").first ?? "") , fileExtension: url.pathExtension, path: downloadPathDirectory) else { return nil }
        return nameWithURL
    }
    
    /// createDirectoryIfNecessaryForPath
    /// - Parameter path: URL
    /// - Returns: URL
    fileprivate func createDirectoryIfNecessaryForPath(_ path: URL) -> URL {
        
        let fileManager = FileManager.default

        var isDirectory: ObjCBool = false
        if !fileManager.fileExists(atPath: path.path, isDirectory: &isDirectory) {
            do {
                try fileManager.createDirectory(at: path, withIntermediateDirectories: true)

                print("Directory created successfully.")
            } catch {
                print("Error creating directory: \(error.localizedDescription)")
            }
        }
        
       return path
    }
    
    /// getPathWith
    /// - Parameters:
    ///   - fileName: String
    ///   - fileExtension: String?
    ///   - path: URL?
    /// - Returns: URL?
    fileprivate  func getPathWith(fileName: String, fileExtension: String?, path: URL?) -> URL?{
                
        if fileName.count > 0 {
            var fileExtensionTemp = fileExtension ?? ""
            if fileExtensionTemp.count == 0  {
                fileExtensionTemp = "png"
            }
            return path?.appending(path: "\(fileName).\(fileExtensionTemp)")
        } else {
            return  nil
        }
    }

}

extension ImageProvider {
    
    /// getCacheDirectoryURL
    /// - Parameter itemID: String
    /// - Returns: URL?
    fileprivate func getCacheDirectoryURL(_ itemID: String) -> URL?{
        
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
                            
        let fileURL = cachesDirectory
            .appending(path: "Download")
            .appending(path: itemID)
        return createDirectoryIfNecessaryForPath(fileURL)
    }
}

extension ImageProvider{
    
    func cropImage(image: UIImage, cropRect: CGRect) -> UIImage? {
        let scaledRect = CGRect(x: cropRect.origin.x * image.scale,
                                y: cropRect.origin.y * image.scale,
                                width: cropRect.size.width * image.scale,
                                height: cropRect.size.height * image.scale)
        
        if let cgImage = image.cgImage?.cropping(to: scaledRect) {
            return UIImage(cgImage: cgImage, scale: image.scale, orientation: image.imageOrientation)
        }
        
        return nil
    }
}


