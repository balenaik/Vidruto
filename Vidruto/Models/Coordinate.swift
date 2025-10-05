//
//  Coordinate.swift
//  Vidruto
//
//  Created by Aika Yamada on 2025/09/28.
//

import CoreLocation

struct Coordinate: Equatable, Hashable {
    let latitude: Double
    let longitude: Double

    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }

    init(clLocationCoordinate2D: CLLocationCoordinate2D) {
        latitude = clLocationCoordinate2D.latitude
        longitude = clLocationCoordinate2D.longitude
    }

    var toCLLocationCoordinate2D: CLLocationCoordinate2D {
        .init(latitude: latitude, longitude: longitude)
    }
}
