//
//  MapSheetDetent.swift
//  Vidruto
//
//  Created by Aika Yamada on 2025/09/19.
//

import SwiftUI

enum MapSheetDetent: Equatable, CaseIterable {
    case collapsed
    case medium
    case expanded

    var toSwiftUI: PresentationDetent {
        switch self {
        case .collapsed: .fraction(0.1)
        case .medium: .medium
        case .expanded: .large
        }
    }
}
