//
//  GalleryCard.swift
//  iOSImageLoader
//
//  Created by Jai Ram Babu on 05/05/24.
//

import SwiftUI

extension Gallery {
    
    struct GalleryCard: View {
        
        @StateObject var model : GalleryModel
        let width: CGFloat
        let height: CGFloat

        var body: some View {

            RoundedRectangle(cornerRadius: 5)
                .fill(Color.white)
                .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 2)
                .overlay(
                    VStack {
            
                        AsyncImage(url: model.downloadedURL) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                .resizable()
                                .scaledToFill()
                                .padding(15)
                            case .failure(_):
                                DefaultImage()
                            @unknown default:
                                DefaultImage()
                            }
                        }
                        .frame(width: width, height: height - 50)
                        .clipShape(Rectangle())
                        
                        Text(model.title)
                            .font(.system(size: 11, weight: .light))
                            .cornerRadius(10)
                            .padding(5)
                            .lineLimit(2)
                        
                    }.onAppear{
                        
                        model.loadImage()
                    }
                )
                .frame(width: width, height: height)
                .padding(10)
            
        }
    }
    
}




//#Preview {
//   // GalleryCard(imageURLString: "")
//}



