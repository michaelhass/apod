//
//  StarProgressView.swift
//  APOD
//
//  Created by Michael Haß on 05.07.25.
//

import SwiftUI

struct StarProgressView: View {
    enum Size {
        case small
        case large
        case custom(CGFloat)

        var value: CGFloat {
            switch self {
            case .small: 20
            case .large: 40
            case .custom(let value): value
            }
        }
    }

    private(set) var size: Size = .small
    private(set) var color: Color = .accentColor

    @State
    private var rotation: Double = 0

    var body: some View {
        Image(systemName: "star.fill")
            .resizable()
            .scaledToFit()
            .frame(width: size.value)
            .foregroundStyle(color)
            .rotationEffect(.degrees(rotation))
            .animation(.default, value: rotation)
            .task(id: rotation) {
                try? await Task.sleep(for: .milliseconds(100))
                rotation += 10
            }
    }
}

#Preview {
    StarProgressView(size: .large, color: .yellow)
}
