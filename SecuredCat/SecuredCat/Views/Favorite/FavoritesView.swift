//
//  FavoritesView.swift
//  SecuredCat
//
//  Created by Jan Kazubski on 30/04/2025.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject var viewModel: FavoritesViewModel
    private let catService: CatService
    
    let columns = [
        GridItem(.adaptive(minimum: 170), spacing: 8)
    ]
    
    init(catService: CatService) {
        _viewModel = StateObject(wrappedValue: FavoritesViewModel(catService: catService))
        self.catService = catService
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                } else if let error = viewModel.error {
                    ErrorView(error: error, onRetry: viewModel.loadFavorites)
                } else if viewModel.favoriteCats.isEmpty {
                    Text("No favorites yet.")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.favoriteCats) { cat in
                            NavigationLink(
                                destination: CatDetails(cat: cat, catService: catService),
                                label: {
                                    SingleCatView(cat: cat)
                                }
                            )
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Favorites")
            .refreshable {
                viewModel.loadFavorites()
            }
            .onAppear {
                viewModel.loadFavorites()
            }
        }
    }
}

#Preview {
    FavoritesView(catService: CatService())
}
