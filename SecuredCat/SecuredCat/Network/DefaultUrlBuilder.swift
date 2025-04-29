//
//  DefaultUrlBuilder.swift
//  Ticketmaster
//
//  Created by Jan Kazubski on 29/04/2025.
//

import Foundation

enum DefaultUrlBuilderError: LocalizedError {
    case invalidPath, invalidUrl
    
    var errorDescription: String? {
        switch self {
        case .invalidPath:
            return "Unable to create URL from the provided path."
        case .invalidUrl:
            return "Unable to create a valid URL from the given components."
        }
    }
}

enum DefaultUrlBuilder {
    static func build(api: ApiConstructor) throws -> URL {
        guard var urlComponentes = URLComponents(string: api.endpoint.fullPath) else {
            throw DefaultUrlBuilderError.invalidPath
        }

        urlComponentes.queryItems = buildQueryParams(api.parameters, ["apikey": NetworkKey.apiKey])
        guard let url = urlComponentes.url else {
            throw DefaultUrlBuilderError.invalidUrl
        }
        
        return url
    }

    private static func buildQueryParams(_ params: Parameters...) -> [URLQueryItem] {
        params.flatMap { $0 }.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
    }
}
