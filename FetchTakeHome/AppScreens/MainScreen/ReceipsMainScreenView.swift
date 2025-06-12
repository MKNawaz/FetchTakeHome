//
//  ReceipsMainScreenView.swift
//  FetchTakeHome
//
//  Created by Khurram Nawaz on 6/11/25.
//

import SwiftUI

struct ReceipsMainScreenView: View {
    @ObservedObject var viewModel: ViewModel
    @State var showSheet: Bool = false
    
    init(appController: AppControllerServices) {
        _viewModel = .init(wrappedValue: .init(appController: appController))
    }
    
    
    var body: some View {
        NavigationStack {
            VStack {
                
                if viewModel.filteredRecepies.count == 0 {
                    VStack {
                        Spacer()
                        Text("No Recipies To Display")
                            .font(.title)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, alignment: .center)
                        Spacer()
                    }
                    
                } else {
                    RecepiesView(viewModel: viewModel, showSheet: $showSheet)
                }
         
                
                FooterView(viewModel: viewModel)
                
            }
            .navigationTitle("Recipes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Refresh") {
                        viewModel.fetchReceipts()
                    }
                }
            }
            .sheet(isPresented: $showSheet, content: {
                if let receipe = viewModel.selectedRecipe {
                    RecipeScreenView(appController: viewModel.appController, recipe: receipe)
                }
            })
           
        }
        

        
    }
}

// MARK: - Scroll View -
fileprivate struct RecepiesView: View {
    @ObservedObject var viewModel: ReceipsMainScreenView.ViewModel
    @Binding var showSheet: Bool
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                
                let columns = [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ]
                LazyVGrid(columns: columns) {
                    
                    ForEach(viewModel.filteredRecepies) { recipe in
                        let cellSize = geometry.size.width/CGFloat(columns.count)
                        VStack {
                            GridCardView(viewModel: viewModel, recipe: recipe, cellSize: cellSize)
                                .onTapGesture {
                                    viewModel.selectedRecipe = recipe
                                    showSheet.toggle()
                                    
                                }
                        }
                        .frame(width: cellSize, height: cellSize)
                        //                            .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.blue, lineWidth: 1)
                        )
                    }
                    
                    
                }
            }
        }
    }
}

fileprivate struct GridCardView: View {
    @ObservedObject var viewModel: ReceipsMainScreenView.ViewModel
    var recipe: RecipeModel
    let cellSize: CGFloat
    
    var body: some View {
        ZStack {
            
            // Background image
            if let image = viewModel.recipeImages[recipe.id] {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: cellSize, height: cellSize)
            } else {
                ProgressView()
                    .frame(width: 60, height: 60)
            }
            
            // overlay
            Color.black.opacity(0.3)
                
                
            // front
            VStack(alignment: .center) {
                Text(recipe.name)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white)
                    .frame(alignment: .center)
                
                Text(recipe.cuisine)
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white)
                    .frame(alignment: .center)

            }
            .padding()
            
        }

    }
}

// MARK: - Footer View -


struct FooterView: View {
    @ObservedObject var viewModel: ReceipsMainScreenView.ViewModel
    var body: some View {
        HStack {
            Text("Showing \(viewModel.recepies.count) recipes")
            Spacer()
            if viewModel.recepies.count > 0 {
                Text("Filter by cuisine:")
                Picker("Cuisine", selection: $viewModel.selectedCuisine) {
                    Text("All").tag(String?.none)
                    ForEach(Array(Set(viewModel.recepies.map { $0.cuisine })), id: \.self) { cuisine in
                        Text(cuisine).tag(String?(cuisine))
                    }
                }
                .pickerStyle(MenuPickerStyle())
            }
            
        }
        .padding(.horizontal)
    }
}

#Preview {
    ReceipsMainScreenView(appController: DummyAppController())
}
