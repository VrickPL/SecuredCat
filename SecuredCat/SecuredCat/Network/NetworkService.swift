//
//  NetworkService.swift
//  Ticketmaster
//
//  Created by Jan Kazubski on 29/04/2025.
//

import Foundation
import Combine

enum NetworkServiceError: LocalizedError, Equatable {
    case invalidResponse(statusCode: Int), invalidApiKey
    
    var errorDescription: String? {
        switch self {
        case .invalidResponse(let statusCode):
            return "Invalid response from server (status code: \(statusCode))"
        case .invalidApiKey:
            return "Invalid ApiKey.\nPlease check your configuration in SecuredCat/Network/NetworkKey.swift"
        }
    }
}

final class NetworkService {
    static let shared = NetworkService()
    private let session = URLSession.shared
    
    func fetchData<T: Decodable>(api: ApiConstructor) -> AnyPublisher<T, Error> {
        do {
            let url = try DefaultUrlBuilder.build(api: api)
            return session.dataTaskPublisher(for: url)
                .tryMap { data, response in
                    guard let httpResponse = response as? HTTPURLResponse else {
                        throw NetworkServiceError.invalidResponse(statusCode: 0)
                    }
                    
                    switch httpResponse.statusCode {
                    case 200..<300:
                        return data
                    case 401:
                        throw NetworkServiceError.invalidApiKey
                    default:
                        throw NetworkServiceError.invalidResponse(statusCode: httpResponse.statusCode)
                    }
                }
                .decode(type: T.self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}
