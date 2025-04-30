//
//  FavoritesView.swift
//  SecuredCat
//
//  Created by Jan Kazubski on 30/04/2025.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject var viewModel = FavoritesViewModel()
    
    let columns = [
        GridItem(.adaptive(minimum: 170), spacing: 8)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                if viewModel.favoriteCats.isEmpty {
                    Text("No favorites yet.")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.favoriteCats, id: \.id) { cat in
                            NavigationLink(
                                destination: CatDetails(cat: cat),
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
        }
    }
}

#Preview {
    FavoritesView()
}
