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
            .sheet(isPresented: $store.isSheetPresented) {
                SheetView(store: store)
                    .presentationDetents(Set(MapSheetDetent.allCases.map(\.toSwiftUI)), selection: $store.sheetDetent)
                    .presentationDragIndicator(.visible)
                    .interactiveDismissDisabled()
                    .presentationBackgroundInteraction(.enabled)
            }
    }
}

private struct SheetView: View {
    @Bindable var store: StoreOf<MapFeature>
    @FocusState var isSearchBarFocused: Bool

    var body: some View {
        VStack(spacing: 0) {
            SearchBar
            Spacer()
        }
        .bind($store.isSearchBarFocused, to: $isSearchBarFocused)
    }

    private var SearchBar: some View {
        HStack {
            Image(systemName: SFSymbolConst.searchBarIconName)
                .foregroundColor(.secondary)

            TextField(String(localized: "mapview_searchbar_placeholder"), text: $store.searchBarText)
                .focused($isSearchBarFocused)
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
