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
    }

    enum Action {
        case didPresentSheet(_ isPresented: Bool)
    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            return .none
        }
    }
}
