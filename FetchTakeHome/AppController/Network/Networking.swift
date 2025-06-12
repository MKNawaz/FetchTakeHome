//
//  Networking.swift
//  FetchTakeHome
//
//  Created by Khurram Nawaz on 6/11/25.
//
import Foundation

protocol NetworkingService {
    func getAllRecepies() async -> [RecipeModel]
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
    
    private struct RecipeResponse: Decodable {
        let recipes: [RecipeModel]
    }
    
}
