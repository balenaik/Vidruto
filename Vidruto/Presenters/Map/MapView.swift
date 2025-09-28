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
            searchBar
            searchResultList
        }
        .bind($store.isSearchBarFocused, to: $isSearchBarFocused)
    }

    private var searchBar: some View {
        HStack {
            Image(systemName: SFSymbolConst.searchBarIconName)
                .foregroundColor(.secondary)

            TextField(String(localized: "mapview_searchbar_placeholder"), text: $store.searchBarText)
                .focused($isSearchBarFocused)
                .textFieldStyle(.plain)
                .onSubmit {
                    store.send(.didPressReturnOnSearchBar)
                }
        }
        .padding(ViewConst.margin8)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: ViewConst.cornerRadius10))
        .padding()
    }

    private var searchResultList: some View {
        List {
            ForEach(store.searchResult, id: \.self) { name in
                Text(name)
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    MapView(
        store: Store(initialState: MapFeature.State()) {
            MapFeature()
        }
    )
}
