//
//  GalleryModel+LoadImage.swift
//  iOSImageLoader
//
//  Created by Jai Ram Babu on 05/05/24.
//

import Foundation

//  imageURL = domain + "/" + basePath + "/0/" + key
// https://cimg.acharyaprashant.org/images/img-c547ce54-1ab5-4cbb-989c-9186f663954e/40/image.jpg
extension Gallery.GalleryModel {
    
    /// loadImage
    func loadImage() {
        
        self.dataTask?.cancel()
        self.setDownloadURL(nil)

        guard let domain =  self.thumbnail?.domain,
              let basePath =  self.thumbnail?.basePath,
              let key = self.thumbnail?.key,
              let thumbnailID = self.thumbnail?.id else {
                return
        }
        
        guard let url = URL(string: domain)?
            .appending(path: basePath)
            .appending(path: "10")
            .appending(path: key) else {
            return
        }
        self.dataTask = ImageProvider.shared.image(id: thumbnailID, remoteURL: url) { [weak self] url in
            self?.setDownloadURL(url)
            self?.dataTask?.cancel()
        }
        self.dataTask?.resume()
    }
    
    private func setDownloadURL(_ url: URL?){
        
        DispatchQueue.main.async { [weak self] in
            self?.downloadedURL = url
        }
    }
}
