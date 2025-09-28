//
//  MapFeatureTests.swift
//  VidrutoTests
//
//  Created by Aika Yamada on 2025/09/06.
//

import ComposableArchitecture
import Foundation
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

    @Test func whenDidPressReturnOnSearchBar_itShouldPassSearchQuery() async throws {
        let searchQuery = LockIsolated<String?>(nil)

        let store = TestStore(initialState: MapFeature.State()) {
            MapFeature()
        } withDependencies: {
            $0.mapSearchClient.search = { query in
                searchQuery.setValue(query)
                return []
            }
        }
        store.exhaustivity = .off

        // Non empty case
        var searchText = UUID().uuidString
        await store.send(\.binding.searchBarText, searchText) {
            $0.searchBarText = searchText
        }
        await store.send(\.didPressReturnOnSearchBar)
        searchQuery.withValue {
            #expect($0 == searchText)
        }

        // Empty case
        searchQuery.setValue(nil)
        searchText = ""
        await store.send(\.binding.searchBarText, searchText) {
            $0.searchBarText = searchText
        }
        await store.send(\.didPressReturnOnSearchBar)
        searchQuery.withValue {
            #expect($0 == nil)
        }
    }

    @Test func onSearchResponseSuccess_itShouldUpdateSearchResult() async throws {
        let searchResult = [UUID().uuidString, UUID().uuidString, UUID().uuidString]
        let store = TestStore(initialState: MapFeature.State()) {
            MapFeature()
        } withDependencies: {
            $0.mapSearchClient.search = { _ in return searchResult }
        }

        let searchQuery = "dummy query"
        await store.send(\.binding.searchBarText, searchQuery) {
            $0.searchBarText = searchQuery
        }
        await store.send(\.didPressReturnOnSearchBar)
        await store.receive(\.searchResponse.success) {
            $0.searchResult = searchResult
        }
    }
}
