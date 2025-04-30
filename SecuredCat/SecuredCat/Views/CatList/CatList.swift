//
//  CatList.swift
//  SecuredCat
//
//  Created by Jan Kazubski on 27/04/2025.
//

import SwiftUI

struct CatList: View {
    @StateObject var viewModel = CatsViewModel()
    
    let columns = [
        GridItem(.adaptive(minimum: 170), spacing: 8)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.cats) { cat in
                        Group {
                            if let breeds = cat.breeds, !breeds.isEmpty {
                                NavigationLink(
                                    destination: CatDetails(cat: cat),
                                    label: {
                                        SingleCatView(cat: cat)
                                    }
                                )
                            } else {
                                SingleCatView(cat: cat)
                            }
                        }.onAppear {
                            if cat.id == viewModel.cats.last?.id && viewModel.hasMore {
                                viewModel.fetchCats()
                            }
                        }
                    }
                }
                .padding()
                
                if let error = viewModel.error {
                    ErrorView(error: error) {
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
        }
        .onAppear {
            viewModel.fetchCats()
        }
    }
}

#Preview {
    CatList()
}
