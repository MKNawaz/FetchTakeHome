//
//  recipe.swift
//  FetchTakeHome
//
//  Created by Khurram Nawaz on 6/11/25.
//
import CoreData
/*
 {
             "cuisine": "British",
             "name": "Bakewell Tart",
             "photo_url_large": "https://some.url/large.jpg",
             "photo_url_small": "https://some.url/small.jpg",
             "uuid": "eed6005f-f8c8-451f-98d0-4088e2b40eb6",
             "source_url": "https://some.url/index.html",
             "youtube_url": "https://www.youtube.com/watch?v=some.id"
         }
 */
struct RecipeModel: Codable, Identifiable {
    
    // TODO: map to RecipeModelEntity
    
    var id: String
    let cuisine: String
    let name: String
    let photoUrlSmall: String
    let photoUrlLarge: String
    let sourceUrl: String?
    let youtubeUrl: String?

    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case cuisine
        case name
        case photoUrlSmall = "photo_url_small"
        case photoUrlLarge = "photo_url_large"
        case sourceUrl = "source_url"
        case youtubeUrl = "youtube_url"
    }
}


// TODO: Extent RecipeModel with following 

protocol DTOObject {
    init (managedObject: NSManagedObject)
    func managedObject() -> NSManagedObject
    func update(from managedObject: NSManagedObject)
}
