//
//  View+Alignment.swift
//  APOD
//
//  Created by Michael Haß on 05.07.25.
//

import SwiftUI

extension View {

    func aligned(_ alignment: Alignment) -> some View {
        self.frame(maxWidth: .infinity, alignment: alignment)
    }
}
