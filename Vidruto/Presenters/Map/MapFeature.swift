//
//  MapFeature.swift
//  Vidruto
//
//  Created by Aika Yamada on 2025/09/11.
//

import ComposableArchitecture

@Reducer
struct MapFeature {
    @ObservableState
    struct State: Equatable {
        var isSheetPresented = true
        var searchBarText = ""
        var isSearchBarFocused = false
        var sheetDetent = MapSheetDetent.collapsed.toSwiftUI
    }

    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case didPresentSheet(_ isPresented: Bool)
    }

    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            return .none
        }
    }
}
