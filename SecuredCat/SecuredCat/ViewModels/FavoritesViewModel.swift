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
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadFavorites()
        FavoritesManager.shared.$favoriteCatIDs
            .sink { [weak self] _ in
                self?.loadFavorites()
            }
            .store(in: &cancellables)
    }
    
    func loadFavorites() {
        favoriteCats = FavoritesManager.shared.getFavoriteCats()
    }
}
