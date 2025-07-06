//
//  View+Padding.swift
//  APOD
//
//  Created by Michael Haß on 06.07.25.
//

import SwiftUI

extension View {
    func pageTopPadding() -> some View {
        self.padding(.top, 32)
    }

    func horizontalContentPadding() -> some View {
        self.padding(.horizontal)
    }
}
