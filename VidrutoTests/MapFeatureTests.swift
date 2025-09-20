//
//  MapFeatureTests.swift
//  VidrutoTests
//
//  Created by Aika Yamada on 2025/09/06.
//

import ComposableArchitecture
import Testing

@testable import Vidruto

@MainActor
struct MapFeatureTests {

    @Test func whenSearchBarFocused__itShouldUpdateSheetDetentLarge() async throws {
        let store = TestStore(initialState: MapFeature.State()) {
            MapFeature()
        }

        // SheetDetent should become large only when isSearchBarFocused is true
        await store.send(\.binding.isSearchBarFocused, true) {
            $0.isSearchBarFocused = true
            $0.sheetDetent = .large
        }
        await store.send(\.binding.sheetDetent, .fraction(0.1)) {
            $0.sheetDetent = .fraction(0.1)
        }
        await store.send(\.binding.isSearchBarFocused, false) {
            $0.isSearchBarFocused = false
        }
        await store.send(\.binding.isSearchBarFocused, false)
    }

}
