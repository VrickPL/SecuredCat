//
//  Endpoint.swift
//  Ticketmaster
//
//  Created by Jan Kazubski on 29/04/2025.
//

import Foundation

enum Endpoint {
    private static let baseUrl = "https://api.thecatapi.com/v1"
    
    case images, imageDetails(String)
    
    var path: String {
        switch self {
        case .images:
            return "/images/search"
        case .imageDetails(let id):
            return "/images/\(id)"
        }
    }
    
    var fullPath: String {
        return Self.baseUrl + path
    }
}
