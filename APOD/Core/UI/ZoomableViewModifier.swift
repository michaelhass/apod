//
//  ZoomableViewModifier.swift
//  APOD
//
//  Created by Michael Haß on 05.07.25.
//

import SwiftUI

@available(iOS 17.0, *)
struct ZoomableViewModifier: ViewModifier {
    @GestureState(resetTransaction: .init(animation: .bouncy))
    private var zoom = 1.0

    func body(content: Content) -> some View {
        content
            .scaleEffect(zoom)
            .gesture(
                MagnifyGesture()
                    .updating($zoom) { value, gestureState, transaction in
                        gestureState = value.magnification
                    }
            )
    }
}

extension View {
    @ViewBuilder
    func zoomable() -> some View {
        if #available(iOS 17, *) {
            self.modifier(ZoomableViewModifier())
        } else {
            self
        }
    }
}
