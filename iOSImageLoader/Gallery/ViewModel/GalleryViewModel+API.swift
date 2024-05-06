//
//  GalleryViewModel+API.swift
//  iOSImageLoader
//
//  Created by Jai Ram Babu on 05/05/24.
//

import Foundation


extension Gallery.GalleryViewModel {
    
    func fetchGallery(_ queryParams: Gallery.GalleryListQueryParam) {
        
        let url = APIServices.GalleryService.queryParams(queryParams)
        
        print("URL:- \(url)")
        
        networkManager.fetch(responseType: [Gallery.GalleryModel].self, url: url) { result in
                    
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.list = response
                }
            case .failure(let failure):
                print(failure)
            }
           

        }

     }
    
}
