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
    @Published var isLoading = false
    
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
        if !isLoading {
            self.isLoading = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                self.favoriteCats = FavoritesManager.shared.getFavoriteCats()
                self.isLoading = false
            }
        }
    }
}
