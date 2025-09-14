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
            SearchBar
            Spacer()
        }
    }

    private var SearchBar: some View {
        HStack {
            Image(systemName: SFSymbolConst.searchBarIconName)
                .foregroundColor(.secondary)

            TextField(String(localized: "mapview_searchbar_placeholder"), text: $store.searchBarText.sending(\.didUpdateSearchBarText))
                .textFieldStyle(.plain)
        }
        .padding(ViewConst.margin8)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: ViewConst.cornerRadius10))
        .padding()
    }
}

#Preview {
    MapView(
        store: Store(initialState: MapFeature.State()) {
            MapFeature()
        }
    )
}
