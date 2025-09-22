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
        var searchResult = [String]()
    }

    // MARK: - Action

    enum Action: BindableAction {
        case binding(BindingAction<State>)
    }

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
            default:
                return .none
            }
        }
    }
}
