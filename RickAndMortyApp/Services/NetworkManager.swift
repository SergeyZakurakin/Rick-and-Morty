//
//  NetworkManager.swift
//  RickAndMortyApp
//
//  Created by Sergey Zakurakin on 13/05/2024.
//


import UIKit


final class NetworkManager {
    
    enum NetworkError: Error {
        case invalidURL
        case invalidResponse
        case noData
        case decodingError
    }
    
    static let shared = NetworkManager()
    
    private init() {}
    
    
    func getData(from url: URL) async throws -> RickAndMorty {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(RickAndMorty.self, from: data)
            
        } catch {
            throw NetworkError.noData
        }
    }
    
    func getImage(from url: String) async throws -> UIImage {
        guard let imageUrl = URL(string: url) else {
            throw NetworkError.invalidURL
        }
        let (data, _) = try await URLSession.shared.data(from: imageUrl)
        
        guard let image = UIImage(data: data) else {
            throw NetworkError.noData
        }
        return image
        
    }
    
    func downloadImage(for imageName: String, callback: @escaping (UIImage?)->()) {
        let urlString = imageName
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 5)
        let dataTask = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
          guard error == nil,
            let data = data,
            let response = response as? HTTPURLResponse,
            response.statusCode == 200 else { return }
          guard let image = UIImage(data: data) else { return }
          DispatchQueue.main.async {
            callback(image)
          }
        }
        dataTask.resume()
      }

    
    
    
    
    

}
