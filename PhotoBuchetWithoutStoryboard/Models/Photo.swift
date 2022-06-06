//
//  Photo.swift
//  PhotoBuchetWithoutStoryboard
//
//  Created by Руслан Штыбаев on 06.06.2022.
//

import Foundation

//struct PhotoResults: Decodable {
//    let total: Int
//    let results: [Photo]
//}

struct Photo: Decodable {
    
    let id: String
    let urls: URLs
    
    let created_at: String?
    let likes: Int?
    let liked_by_user: Bool?
    let user: User
}

// MARK: - User
struct User: Decodable {
    let name: String
    let location: String?
}

// MARK: - Urls
struct URLs: Decodable {
    let small: String
}
