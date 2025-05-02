//
//  CatDetailsViewModel.swift
//  SecuredCat
//
//  Created by Jan Kazubski on 01/05/2025.
//

import Foundation
import Combine

final class CatDetailsViewModel: ObservableObject {
    @Published var cat: Cat
    @Published var isLoading = false
    @Published var error: Error? = nil

    private let catService: CatService
    private var cancellables = Set<AnyCancellable>()

    init(cat: Cat, catService: CatService) {
        self.catService = catService
        self.cat = cat
        
        if cat.breeds == nil {
            loadCatDetails()
        }
    }

    func loadCatDetails() {
        isLoading = true
        catService.fetchCatDetails(by: cat.id)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let err) = completion {
                    self?.error = err
                } else {
                    self?.error = nil
                }
            } receiveValue: { [weak self] fetchedCat in
                self?.cat = fetchedCat
            }
            .store(in: &cancellables)
    }
}
