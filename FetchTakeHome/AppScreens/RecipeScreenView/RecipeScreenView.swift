//
//  RecipeScreenView.swift
//  FetchTakeHome
//
//  Created by Khurram Nawaz on 6/11/25.
//

import SwiftUI

struct RecipeScreenView: View {
    @ObservedObject var viewModel: ViewModel
    @Environment(\.dismiss) var dismiss
    init(appController: AppControllerServices, recipe: RecipeModel) {
        _viewModel = .init(wrappedValue: .init(appController: appController, recipe: recipe))
    }

    var body: some View {
        NavigationStack
        {
            
            
            ScrollView {
                VStack(spacing: 16) {
                    
                    ImageLoaderView(viewModel: viewModel)
                    
                    DetailsView(viewModel: viewModel)
                }
                .padding()
            }
            .navigationTitle(viewModel.recipe.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Close") {
                        dismiss()
                    }
                    .padding()
                }
            }
        }
    }
}

fileprivate struct ImageLoaderView: View {
    @ObservedObject var viewModel: RecipeScreenView.ViewModel
    
    var body: some View {
        AsyncImage(url: URL(string: viewModel.recipe.photoUrlLarge)) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(height: 250)
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            case .failure:
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
            @unknown default:
                EmptyView()
            }
        }
        .frame(maxWidth: .infinity)
    }
}

fileprivate struct DetailsView: View {
    @ObservedObject var viewModel: RecipeScreenView.ViewModel
    
    var body: some View {
        Text(viewModel.recipe.name)
            .font(.title)
            .padding()
        
        Text("Cuisine: \(viewModel.recipe.cuisine)")
            .font(.subheadline)
        
        if let youtubeUrl = viewModel.recipe.youtubeUrl {
            Button("Watch Video") {
                UIApplication.shared.open(URL(string: youtubeUrl)!)
            }
        }
        
        if let summary = viewModel.recipe.sourceUrl {
            Text("Source: \(summary)")
                .font(.caption)
        }
    }
}

#Preview {
    RecipeScreenView(appController: DummyAppController(), recipe: RecipeModel(id: "123",
                                                                              cuisine: "Test",
                                                                              name: "Test 1",
                                                                              photoUrlSmall: "",
                                                                              photoUrlLarge: "",
                                                                              sourceUrl: nil,
                                                                              youtubeUrl: nil))
}
