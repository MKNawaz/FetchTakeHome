//
//  ReceipsMainScreenView+ViewModel.swift
//  FetchTakeHome
//
//  Created by Khurram Nawaz on 6/11/25.
//
import SwiftUI


extension ReceipsMainScreenView {
    final class ViewModel: ObservableObject {
        
        let appController: AppControllerServices
        
        init(appController: AppControllerServices) {
            self.appController = appController
        }
        
        
        @Published var recepies: [RecipeModel] = []
        @Published var recipeImages: [String: UIImage] = [:]
        @Published var selectedCuisine: String? = nil
        @Published var selectedRecipe: RecipeModel? = nil
        
        // 
        var filteredRecepies: [RecipeModel] {
            if let cuisine = selectedCuisine, !cuisine.isEmpty {
                return recepies.filter { $0.cuisine == cuisine }
            }
            return recepies
        }
        
        @MainActor
        func fetchReceipts() {
            Task {
                let recepies = await appController.getReceipties()
                self.recepies = recepies

                for recipe in recepies {
                    fetchImage(for: recipe)
                }
            }
        }
        
        
        @MainActor
        func fetchImage(for recipe: RecipeModel) {
            Task {
                if let image = await appController.getImage(for: recipe.photoUrlSmall) {
                    recipeImages[recipe.id] = image
                }
            }
        }
    }
}
