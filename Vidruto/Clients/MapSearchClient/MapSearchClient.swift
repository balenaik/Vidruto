//
//  MapSearchClient.swift
//  Vidruto
//
//  Created by Aika Yamada on 2025/09/21.
//

import ComposableArchitecture

@DependencyClient
struct MapSearchClient {
    var search: @Sendable (_ query: String) async throws -> [String]
}

extension DependencyValues {
    var mapSearchClient: MapSearchClient {
        get { self[MapSearchClient.self] }
        set { self[MapSearchClient.self] = newValue }
    }
}
