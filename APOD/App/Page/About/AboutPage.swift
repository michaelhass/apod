//
//  AboutPage.swift
//  APOD
//
//  Created by Michael Haß on 06.07.25.
//

import SwiftUI

struct AboutPage: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: .verticalContentSpacing) {
                Text("About")
                    .font(.title)
                    .foregroundStyle(.titleText)
                    .aligned(.leading)

                Text("Hello, World!")
                    .font(.body)
                    .foregroundStyle(.primaryText)
                    .aligned(.leading)
            }
            .pageTopPadding()
            .horizontalContentPadding()
            .frame(maxWidth: .infinity)
        }
    }
}
