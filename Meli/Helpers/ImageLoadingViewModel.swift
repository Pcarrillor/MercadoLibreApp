//
//  ImageLoadingViewModel.swift
//  Meli
//
//  Created by Pedro Carrillo on 23/02/24.
//

import Foundation
import SwiftUI
import Combine

class ImageLoadingViewModel: ObservableObject {
    
    @Published var image: UIImage?
    @Published var isLoading: Bool = false
    var cancellable = Set<AnyCancellable>()
    let manager = ImageModelCacheManager.instance
    
    let urlString: String
    let imageKey: String
    
    init(url: String, key: String) {
        urlString = url
        imageKey = key
        getImage()
    }
    
    func getImage(){
        if let savedImage = manager.get(key: imageKey) {
            image = savedImage
            debugPrint("Image from Cache")
        } else {
            downloadImage()
            debugPrint("Downloading Image")
        }
    }
    
    func downloadImage() {
        isLoading = true
        guard let url = URL(string: urlString.replacingOccurrences(of: "http://", with: "https://")) else {
            isLoading = false
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map {UIImage(data: $0.data)}
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (_)in
                self?.isLoading = false
            } receiveValue: { [weak self] (returnedImage) in
                guard let self = self,
                      let image = returnedImage else { return }
                self.image = image
                self.manager.add(key: self.imageKey, value: image)
            }
            .store(in: &cancellable)
    }
    
}
