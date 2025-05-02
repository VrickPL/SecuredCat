//
//  CatList.swift
//  SecuredCat
//
//  Created by Jan Kazubski on 27/04/2025.
//

import SwiftUI

struct CatList: View {
    @StateObject var viewModel: CatsViewModel
    private let catService: CatService
    
    let columns = [
        GridItem(.adaptive(minimum: 170), spacing: 8)
    ]
    
    init(catService: CatService) {
        _viewModel = StateObject(wrappedValue: CatsViewModel(catService: catService))
        self.catService = catService
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                if !viewModel.searchQuery.trimmingCharacters(in: .whitespaces).isEmpty {
                    if viewModel.searchCats.isEmpty && !viewModel.isLoading {
                        Text("No search results found.")
                            .foregroundColor(.gray)
                            .padding()
                    } else {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(viewModel.searchCats) { cat in
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
                } else {
                    if viewModel.cats.isEmpty && viewModel.error == nil && !viewModel.isLoading {
                        Text("No cats available.")
                            .foregroundColor(.gray)
                            .padding()
                    } else {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(viewModel.cats) { cat in
                                NavigationLink(
                                    destination: CatDetails(cat: cat, catService: catService),
                                    label: {
                                        SingleCatView(cat: cat)
                                    }
                                )
                                .onAppear {
                                    if cat.id == viewModel.cats.last?.id && viewModel.hasMore {
                                        viewModel.fetchCats()
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                }
                
                if let error = viewModel.error {
                    ErrorView(error: error) {
                        viewModel.error = nil
                        viewModel.fetchCats()
                    }
                }
                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                }
            }
            .refreshable {
                viewModel.refresh()
            }
            .navigationTitle("Cats")
            .searchable(text: $viewModel.searchQuery)
        }
        .onAppear {
            if viewModel.cats.isEmpty {
                viewModel.fetchCats()
            }
        }
    }
}

#Preview {
    CatList(catService: CatService())
}
