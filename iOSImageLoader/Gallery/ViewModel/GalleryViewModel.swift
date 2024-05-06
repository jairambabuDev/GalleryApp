//
//  GalleryViewModel.swift
//  iOSImageLoader
//
//  Created by Jai Ram Babu on 05/05/24.
//

import Foundation

// MARK: Module within Encapsulation
struct Gallery{
}
extension Gallery{
        
    final class GalleryViewModel : ObservableObject {
        
        let networkManager: NetworkManagerHelper = NetworkManagerHelper()
        
        @MainActor @Published var list = [GalleryModel]()
        
        deinit {
            print("GalleryViewModel deinit")
        }
    }
}
