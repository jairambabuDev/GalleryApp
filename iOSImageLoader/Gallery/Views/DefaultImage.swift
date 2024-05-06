//
//  DefaultImage.swift
//  iOSImageLoader
//
//  Created by Jai Ram Babu on 05/05/24.
//

import SwiftUI


struct DefaultImage: View {
    var body: some View {
        Image(systemName: "photo") // Placeholder for failed image
            .resizable()
            .aspectRatio(contentMode: .fill)
            .cornerRadius(10)
            .padding(25)
    }
}

#Preview {
    DefaultImage()
}
