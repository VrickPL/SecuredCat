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
        favoriteCats = []
        isLoading = true
        
        let localFavorites = FavoritesManager.shared.getFavoriteCats()
        
        let publishers = localFavorites.map { localCat in
            catService.fetchCatDetails(by: localCat.id)
                .replaceError(with: localCat)
        }
        
        Publishers.MergeMany(publishers)
            .collect()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.error = error
                }
            } receiveValue: { [weak self] cats in
                self?.favoriteCats = cats
            }
            .store(in: &cancellables)
    }
}
