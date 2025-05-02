//
//  CatsViewModel.swift
//  SecuredCat
//
//  Created by Jan Kazubski on 29/04/2025.
//

import Foundation
import Combine

final class CatsViewModel: ObservableObject {
    @Published var cats: [Cat] = []
    @Published var searchCats: [Cat] = []
    @Published var isLoading = false
    @Published var error: Error?
    @Published var hasMore = true
    @Published var searchQuery: String = "" {
        didSet {
            let trimmedQuery = searchQuery.trimmingCharacters(in: .whitespaces)
            if trimmedQuery.isEmpty {
                searchCats = []
            } else {
                fetchSearchCats(with: trimmedQuery)
            }
        }
    }
    
    private let catService: CatService
    private var cancellables = Set<AnyCancellable>()
    
    private let catsLimitInQuery = 10
    private var currentPage = 0
    
    init(catService: CatService) {
        self.catService = catService
        fetchCats()
    }
    
    func fetchCats() {
        guard !isLoading else {
            return
        }
        
        isLoading = true
        
        let parameters = [
            "page": String(currentPage),
            "limit": String(catsLimitInQuery),
            "has_breeds": "1"
        ]
        
        let apiConstructor = ApiConstructor(endpoint: .images, parameters: parameters)
        catService.fetchCats(api: apiConstructor)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let fetchError) = completion {
                    self?.error = fetchError
                } else {
                    self?.error = nil
                }
            } receiveValue: { [weak self] newCats in
                self?.cats.append(contentsOf: newCats)
                self?.hasMore = newCats.count == self?.catsLimitInQuery

                if self?.hasMore == true {
                    self?.currentPage += 1
                }
            }
            .store(in: &cancellables)
    }
    
    func fetchSearchCats(with query: String) {
        isLoading = true
        
        let parameters: [String: String] = [
            "limit": String(catsLimitInQuery),
            "has_breeds": "1",
            "breed_ids": query.lowercased() + ","
        ]
        
        let apiConstructor = ApiConstructor(endpoint: .images, parameters: parameters)
        catService.fetchCats(api: apiConstructor)
            .replaceError(with: [])
            .sink { [weak self] matchedCats in
                self?.searchCats = matchedCats
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }
    
    func refresh() {
        error = nil
        cats.removeAll()
        hasMore = true
        currentPage = 0
        fetchCats()
    }
}
