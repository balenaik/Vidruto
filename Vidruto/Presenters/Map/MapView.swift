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
            .sheet(isPresented: $store.isSheetPresented.sending(\.didPresentSheet)) {
                SheetView
                    .presentationDetents([.fraction(0.1), .medium, .large])
                    .presentationDragIndicator(.visible)
                    .interactiveDismissDisabled()
                    .presentationBackgroundInteraction(.enabled)
            }
    }

    private var SheetView: some View {
        VStack(spacing: 0) {
            Spacer()
        }
    }
}

#Preview {
    MapView(
        store: Store(initialState: MapFeature.State()) {
            MapFeature()
        }
    )
}
