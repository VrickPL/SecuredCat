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
                        SingleCatView(cat: cat).onAppear {
                            if cat.id == viewModel.cats.last?.id && viewModel.hasMore {
                                viewModel.fetchCats()
                            }
                        }
                    }
                }
                .padding()
                
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
