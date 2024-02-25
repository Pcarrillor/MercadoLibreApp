//
//  ImageModelCacheManager.swift
//  Meli
//
//  Created by Pedro Carrillo on 23/02/24.
//

import Foundation
import SwiftUI

class ImageModelCacheManager {
    static let instance = ImageModelCacheManager()
    
    private init() { }
    
    var imageCache: NSCache<NSString, UIImage> = {
       var cache = NSCache<NSString, UIImage>()
        cache.countLimit = 50
        cache.totalCostLimit = 1024 * 1024 * 50
        return  cache
    }()
    
    func add(key: String, value: UIImage){
        imageCache.setObject(value as UIImage, forKey: key as  NSString)
    }
    
    func get(key: String) -> UIImage? {
        return imageCache.object(forKey: key as NSString)
    }
}
