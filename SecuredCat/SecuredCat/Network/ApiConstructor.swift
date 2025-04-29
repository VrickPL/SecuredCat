//
//  ApiConstructor.swift
//  Ticketmaster
//
//  Created by Jan Kazubski on 29/04/2025.
//

import Foundation

typealias Parameters = [String: String]

struct ApiConstructor {
    let endpoint: Endpoint
    var parameters = Parameters()
}
