//
//  DefaultSheetStyleModifier.swift
//  APOD
//
//  Created by Michael Haß on 05.07.25.
//

import SwiftUI

struct DefaultSheetStyleModifier: ViewModifier {
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    let topContentPadding: CGFloat

    var dragIndicatorVisibility: Visibility {
        if verticalSizeClass == .regular && horizontalSizeClass == .regular {
            .hidden
        } else {
            .visible
        }
    }

    func body(content: Content) -> some View {
        content
            .pageTopPadding()
            .presentationDragIndicator(dragIndicatorVisibility)
            .presentationDetents([.medium])
            .presentationBackground(.thinMaterial)
    }
}

extension View {
    func defaultSheetStyle(topContentPadding: CGFloat = 32) -> some View {
        self.modifier(DefaultSheetStyleModifier(topContentPadding: topContentPadding))
    }
}
