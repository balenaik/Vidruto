//
//  MapPoint.swift
//  Vidruto
//
//  Created by Aika Yamada on 2025/09/27.
//

import CoreLocation

struct MapPoint: Equatable, Hashable, Identifiable {
    let id = UUID()
    let name: String
    let coordinate: Coordinate
}
