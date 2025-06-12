//
//  Networking.swift
//  FetchTakeHome
//
//  Created by Khurram Nawaz on 6/11/25.
//
import Foundation
import UIKit

protocol NetworkingService {
    func getAllRecepies() async -> [RecipeModel]
    func loadImage(from urlString: String) async throws -> UIImage
}


class Networking: NetworkingService {
    

    private let server: CommServerServices
    
    init(server: CommServerServices = CommServer()) {
        self.server = server
    }
    
    // MARK: - Server Calls -
    
    func getAllRecepies() async -> [RecipeModel] {
        do {
            let data = try await server.getData(urlString: NetworkAPIs.recepies)
            let decoded = try JSONDecoder().decode(RecipeResponse.self, from: data)
            return decoded.recipes
        } catch {
            print("Failed to fetch or decode recipes: \(error)")
            return []
        }
    }
    
    private var imageCache = NSCache<NSString, UIImage>()
    
    func loadImage(from urlString: String) async throws -> UIImage {
        if let cached = imageCache.object(forKey: urlString as NSString) {
            return cached
        }
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let image = UIImage(data: data) else {
            throw URLError(.cannotDecodeContentData)
        }
        
        imageCache.setObject(image, forKey: urlString as NSString)
        return image
    }
    
    
    private struct RecipeResponse: Decodable {
        let recipes: [RecipeModel]
    }
    
}
