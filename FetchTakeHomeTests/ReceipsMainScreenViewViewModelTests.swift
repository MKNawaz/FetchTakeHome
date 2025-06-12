//
//  ReceipsMainScreenViewViewModelTests.swift
//  FetchTakeHomeTests
//
//  Created by Khurram Nawaz on 6/11/25.
//

import XCTest
@testable import FetchTakeHome

final class ReceipsMainScreenViewViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    class MockAppController: AppControllerServices {
           var mockRecipes: [RecipeModel] = []
           var mockImage: UIImage? = UIImage(systemName: "photo")

           func getReceipties() async -> [RecipeModel] {
               return mockRecipes
           }

           func getImage(for urlString: String) async -> UIImage? {
               return mockImage
           }
       }

       func testFetchReceipts_PopulatesRecipesAndImages() async {
           // Arrange
           let mockController = MockAppController()
           mockController.mockRecipes = [
               RecipeModel(
                   id: "id-1",
                   cuisine: "Italian",
                   name: "Pizza",
                   photoUrlSmall: "https://example.com/small.jpg",
                   photoUrlLarge: "https://example.com/large.jpg",
                   sourceUrl: "",
                   youtubeUrl: ""
               )
           ]

           let viewModel = ReceipsMainScreenView.ViewModel(appController: mockController)

           // Act
           await viewModel.fetchReceipts()
           
           // wait for the task to execute
           sleep(1)

           // Assert
           XCTAssertEqual(viewModel.recepies.count, 1)
           XCTAssertEqual(viewModel.recepies.first?.name, "Pizza")
           XCTAssertEqual(viewModel.recipeImages["id-1"], mockController.mockImage)
       }

       func testFilteredRecepies_ByCuisine() {
           // Arrange
           let mockController = MockAppController()
           let viewModel = ReceipsMainScreenView.ViewModel(appController: mockController)

           viewModel.recepies = [
            RecipeModel(id: "1", cuisine: "Mexican", name: "Taco", photoUrlSmall: "", photoUrlLarge: "", sourceUrl: "", youtubeUrl: ""),
            RecipeModel(id: "2", cuisine: "Italian", name: "Pasta", photoUrlSmall: "", photoUrlLarge: "", sourceUrl: "", youtubeUrl: "")
           ]
           viewModel.selectedCuisine = "Italian"

           // Act
           let filtered = viewModel.filteredRecepies

           // Assert
           XCTAssertEqual(filtered.count, 1)
           XCTAssertEqual(filtered.first?.name, "Pasta")
       }

}
