//
//  AppController.swift
//  FetchTakeHome
//
//  Created by Khurram Nawaz on 6/11/25.
//
import Foundation
import UIKit

// Interface for all the services that will be utilized by any View
protocol AppControllerServices {
    func getReceipties() async -> [RecipeModel]
    func getImage(for urlString: String) async -> UIImage?
}


class AppController: AppControllerServices {
   
    private var network: NetworkingService
   // private var datastore: DatastoreService
    
    
    init(networkService: NetworkingService = Networking()) {
        self.network = networkService
    }
    
    
    // MARK: - Data Providers -
    // MARK: - Getters -
    func getReceipties() async -> [RecipeModel] {
        await self.network.getAllRecepies()
    }
    
    func getImage(for urlString: String) async -> UIImage? {
        do {
            return try await network.loadImage(from: urlString)
        } catch {
            print("Image fetch error: \(error)")
            return nil
        }
    }
    
}

#if DEBUG
class DummyAppController: AppControllerServices {
    func getReceipties() async -> [RecipeModel] {
        return [RecipeModel(id: "1232131233", cuisine: "Test 1", name: "one", photoUrlSmall: "", photoUrlLarge: "", sourceUrl: nil, youtubeUrl: nil),
                RecipeModel(id: "1232131234", cuisine: "Test 2", name: "Two", photoUrlSmall: "", photoUrlLarge: "", sourceUrl: nil, youtubeUrl: nil),
                RecipeModel(id: "1232131235", cuisine: "Test 3", name: "Three", photoUrlSmall: "", photoUrlLarge: "", sourceUrl: nil, youtubeUrl: nil)]
    }
    
    func getImage(for urlString: String) async -> UIImage? {
        nil
    }
}
#endif
