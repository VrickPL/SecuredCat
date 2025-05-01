//
//  CatService.swift
//  SecuredCat
//
//  Created by Jan Kazubski on 29/04/2025.
//

import Foundation
import Combine

final class CatService {
    private let networkService = NetworkService.shared
    
    func fetchCats(api: ApiConstructor) -> AnyPublisher<[Cat], Error> {
        return networkService.fetchData(api: api)
    }
    
    func fetchCatDetails(by catId: String) -> AnyPublisher<Cat, Error> {
        let apiConstructor = ApiConstructor(endpoint: .imageDetails(catId), parameters: [:])
        return networkService.fetchData(api: apiConstructor)
    }
}
