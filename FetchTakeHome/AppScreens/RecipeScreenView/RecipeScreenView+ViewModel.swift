//
//  RecipeScreenView+ViewModel.swift
//  FetchTakeHome
//
//  Created by Khurram Nawaz on 6/11/25.
//
import SwiftUI

extension RecipeScreenView {
    final class ViewModel: ObservableObject {
        
        let appController: AppControllerServices
        let recipe: RecipeModel
        
        init(appController: AppControllerServices, recipe: RecipeModel) {
            self.appController = appController
            self.recipe = recipe
        }
        
    }
}
