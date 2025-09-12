//
//  MapView.swift
//  Vidruto
//
//  Created by Aika Yamada on 2025/09/06.
//

import ComposableArchitecture
import SwiftUI
import MapKit

struct MapView: View {
    @Bindable var store: StoreOf<MapFeature>

    var body: some View {
        Map()
    }
}

#Preview {
    MapView(
        store: Store(initialState: MapFeature.State()) {
            MapFeature()
        }
    )
}
