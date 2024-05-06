//
//  GalleryView.swift
//  iOSImageLoader
//
//  Created by Jai Ram Babu on 05/05/24.
//

import SwiftUI

extension Gallery {
    
    struct GalleryView: View {
        
        @StateObject private var galleryVM = GalleryViewModel()
        
        var body: some View {
            
            GeometryReader(content: { geometry in
                ScrollView {
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 5), count: 3), spacing: 5) {

                        ForEach(galleryVM.list, id: \.id) { item in
                            let width = (geometry.size.width / 3) - 20
                            GalleryCard(model: item, width: width, height: width + 50)
                            
                        }
                    }
                    .padding()
                    
                    
                    
                }
            }).task {
                galleryVM.fetchGallery(Gallery.GalleryListQueryParam(limit: "100"))

            }
            
        }
    }
}

#Preview {
    Gallery.GalleryView()
}
