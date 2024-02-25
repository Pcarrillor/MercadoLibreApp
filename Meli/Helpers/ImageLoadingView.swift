//
//  ImageLoadingView.swift
//  Meli
//
//  Created by Pedro Carrillo on 23/02/24.
//

import SwiftUI

struct ImageLoadingView: View {
    @StateObject var loader: ImageLoadingViewModel
        
    init(url: String, key: String) {
            _loader = StateObject(wrappedValue: ImageLoadingViewModel(url: url, key: key))
        }
        
        var body: some View {
            if loader.isLoading {
                ProgressView().foregroundColor(.white)
            } else if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(15)
            }
        }
}

struct ImageLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        ImageLoadingView(url: "", key: "1")
    }
}
