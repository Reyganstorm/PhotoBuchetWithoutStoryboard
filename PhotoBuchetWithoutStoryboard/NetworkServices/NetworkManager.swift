//
//  NetworkManager.swift
//  PhotoBuchetWithoutStoryboard
//
//  Created by Руслан Штыбаев on 06.06.2022.
//

import Foundation

enum Links: String {
    case link = "https://api.unsplash.com/photos/?client_id=bpH1swrQ1vFDTkzwyCoMc5F2DCof1g-WWCJg_3svu0c"
    case id = "https://api.unsplash.com/photos/Y2ravKRtQZ0/like/?client_id=bpH1swrQ1vFDTkzwyCoMc5F2DCof1g-WWCJg_3svu0c"
    case like = "https://api.unsplash.com//users/rey_shay/likes/?client_id=bpH1swrQ1vFDTkzwyCoMc5F2DCof1g-WWCJg_3svu0c"
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func fetch(from url: String, with completion: @escaping(Result<[Photo], NetworkError>) -> Void ) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "NO Error description")
                return
            }
            do {
                let type = try JSONDecoder().decode([Photo].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(type))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
