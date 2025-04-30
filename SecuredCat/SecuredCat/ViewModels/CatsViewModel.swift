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
    @Published var isLoading = false
    @Published var error: Error?
    @Published var hasMore = true
    @Published var searchQuery: String = "" {
        didSet {
            refresh()
        }
    }
    
    private let catService: CatService
    private var cancellables = Set<AnyCancellable>()
    
    private let catsLimitInQuery = 10
    private var currentPage = 0
    
    init(catService: CatService = CatService()) {
        self.catService = catService
        fetchCats()
    }
    
    func fetchCats() {
        guard !isLoading else {
            return
        }
        
        isLoading = true
        
        var parameters = [
            "page": String(currentPage),
            "limit": String(catsLimitInQuery),
            "has_breeds": "1"
        ]
        
        let search = searchQuery.trimmingCharacters(in: .whitespaces)
        if !search.isEmpty {
            parameters["breed_ids"] = search.lowercased() + ","
        }
        
        let apiConstructor = ApiConstructor(endpoint: .images, parameters: parameters)
        catService.fetchCats(api: apiConstructor)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let fetchError) = completion {
                    self?.error = fetchError
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
    
    func refresh() {
        error = nil
        cats.removeAll()
        hasMore = true
        currentPage = 0
        fetchCats()
    }
}
