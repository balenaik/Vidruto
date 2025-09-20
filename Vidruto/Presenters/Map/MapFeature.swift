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
        var sheetDetent = MapSheetDetent.collapsed.toSwiftUI
    }

    enum Action {
        case didPresentSheet(_ isPresented: Bool)
        case didUpdateSearchBarText(_ text: String)
    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            return .none
        }
    }
}
