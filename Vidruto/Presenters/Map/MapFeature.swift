//
//  MapFeature.swift
//  Vidruto
//
//  Created by Aika Yamada on 2025/09/11.
//

import ComposableArchitecture

@Reducer
struct MapFeature {

    // MARK: - State

    @ObservableState
    struct State: Equatable {
        var isSheetPresented = true
        var searchBarText = ""
        var isSearchBarFocused = false
        var sheetDetent = MapSheetDetent.collapsed.toSwiftUI
        var searchResult = [MapPoint]()
        var selectedPoint: MapPoint?
    }

    // MARK: - Action

    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case didPressReturnOnSearchBar
        case searchResponse(Result<[MapPoint], Error>)
        case didTapSearchResultItem(MapPoint)
    }

    // MARK: - Dependency

    @Dependency(\.mapSearchClient) var mapSearchClient

    // MARK: - Body

    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding(\.isSearchBarFocused):
                if state.isSearchBarFocused {
                    state.sheetDetent = .large
                }
                return .none
            case .didPressReturnOnSearchBar:
                return searchPlaces(query: state.searchBarText)
            case let .searchResponse(.success(places)):
                state.searchResult = places
                return .none
            case .didTapSearchResultItem(let mapPoint):
                state.selectedPoint = mapPoint
                state.sheetDetent = MapSheetDetent.medium.toSwiftUI
                return .none
            default:
                return .none
            }
        }
    }
}

// MARK: - Search Functions

private extension MapFeature {
    func searchPlaces(query: String) -> Effect<Action> {
        guard !query.isEmpty else { return .none }

        return .run { send in
            do {
                let results = try await mapSearchClient.search(query)
                await send(.searchResponse(.success(results)))
            } catch {
                await send(.searchResponse(.failure(error)))
            }
        }
    }
}
