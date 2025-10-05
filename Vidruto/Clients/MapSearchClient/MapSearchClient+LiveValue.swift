//
//  MapSearchClient+LiveValue.swift
//  Vidruto
//
//  Created by Aika Yamada on 2025/09/21.
//

import Dependencies
import MapKit

extension MapSearchClient: DependencyKey {
    static let liveValue = Self(
        search: { query in
            let request = MKLocalSearch.Request()
            request.naturalLanguageQuery = query
            let search = MKLocalSearch(request: request)
            let response = try await search.start()
            return response.mapItems.compactMap { item -> MapPoint? in
                guard let name = item.name,
                      let coordinate = item.placemark.location?.coordinate else {
                    return nil
                }
                return MapPoint(name: name, coordinate: Coordinate(clLocationCoordinate2D: coordinate))
            }
        }
    )

    static let testValue = Self()
}
