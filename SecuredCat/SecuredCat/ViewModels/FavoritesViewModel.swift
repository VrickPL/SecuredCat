//
//  FavoritesViewModel.swift
//  SecuredCat
//
//  Created by Jan Kazubski on 30/04/2025.
//

import Foundation
import Combine

final class FavoritesViewModel: ObservableObject {
    @Published var favoriteCats: [Cat] = []
    @Published var isLoading: Bool = false
    @Published var error: Error? = nil
    
    private let catService: CatService
    private var cancellables = Set<AnyCancellable>()
    
    init(catService: CatService = CatService()) {
        self.catService = catService

        loadFavorites()
        FavoritesManager.shared.$favoriteCatIDs
            .sink { [weak self] _ in
                self?.loadFavorites()
            }
            .store(in: &cancellables)
    }
    
    func loadFavorites() {
        isLoading = true
        favoriteCats = FavoritesManager.shared.getFavoriteCats()
        isLoading = false
    }
}
