//
//  ImageManager.swift
//  PhotoBuchetWithoutStoryboard
//
//  Created by Руслан Штыбаев on 06.06.2022.
//

import Foundation

class ImageManager {
    static let shared = ImageManager()
    private init() {}
    
    func fetch(from url: URL, with completion: @escaping(Data, URLResponse) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, responce, error in
            guard let data = data, let responce = responce else {
                print(error?.localizedDescription ?? "NO ERROR descrioption")
                return
            }
            
            guard url == responce.url else {return}
            
            DispatchQueue.main.async {
                completion(data, responce)
            }
        }.resume()
    }
}
