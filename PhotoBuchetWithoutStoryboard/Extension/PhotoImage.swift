//
//  PhotoImage.swift
//  PhotoBuchetWithoutStoryboard
//
//  Created by Руслан Штыбаев on 06.06.2022.
//

import UIKit

class PhotoImage: UIImageView {
    func fetch(from url: String) {
        guard let url = URL(string: url) else {
            image = UIImage(named: "")
            return
        }
        
        if let cachedImage = getCachedImage(from: url) {
            image = cachedImage
            return
        }
        
        ImageManager.shared.fetch(from: url) { data, response in
            self.image = UIImage(data: data)
            self.saveDataToCache(with: data, and: response)
        }
    }
    
    private func saveDataToCache(with data: Data, and response: URLResponse) {
        guard let url = response.url else {return}
        let request = URLRequest(url: url)
        let cashedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cashedResponse, for: request)
    }
    
    private func getCachedImage(from url: URL) -> UIImage? {
        let request = URLRequest(url: url)
        if let cachedImage = URLCache.shared.cachedResponse(for: request) {
            return UIImage(data: cachedImage.data)
        }
        return nil
    }
}
