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
        contentMap
            .sheet(isPresented: $store.isSheetPresented) {
                SheetView(store: store)
                    .presentationDetents(Set(MapSheetDetent.allCases.map(\.toSwiftUI)), selection: $store.sheetDetent)
                    .presentationDragIndicator(.visible)
                    .interactiveDismissDisabled()
                    .presentationBackgroundInteraction(.enabled)
            }
    }

    private var contentMap: some View {
        Map(initialPosition: .region(initialRegion)) {
            store.selectedPoint.map {
                Marker(
                    $0.name,
                    coordinate: $0.coordinate.toCLLocationCoordinate2D
                )
            }
        }
    }

    private var initialRegion: MKCoordinateRegion {
        MKCoordinateRegion(
            center: store.selectedPoint?.coordinate.toCLLocationCoordinate2D ?? .init(latitude: 0, longitude: 0),
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        )
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
        List(store.searchResult) { mapPoint in
            Button {
                store.send(.didTapSearchResultItem(mapPoint))
            } label: {
                Text(mapPoint.name)
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
