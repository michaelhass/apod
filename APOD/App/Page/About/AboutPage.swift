//
//  AboutPage.swift
//  APOD
//
//  Created by Michael Haß on 06.07.25.
//

import SwiftUI

struct AboutPage: View {
    let links: [String] = [
        "https://github.com/nasa/apod-api",
        "https://apod.nasa.gov/apod/astropix.html",
    ]
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: .verticalContentSpacing) {
                Text("About")
                    .font(.title)
                    .foregroundStyle(.titleText)
                    .aligned(.leading)

                Text("This is small test project using SwiftUI.")
                    .font(.body)
                    .foregroundStyle(.primaryText)
                    .aligned(.leading)

                Text("Links")
                    .font(.title2)
                    .foregroundStyle(.primaryText)
                    .aligned(.leading)


                ForEach(links, id: \.self) { link in
                    Text(LocalizedStringKey(link))
                        .font(.body)
                        .foregroundStyle(.primaryText)
                        .aligned(.leading)
                }
            }
            .pageTopPadding()
            .horizontalContentPadding()
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
   AboutPage()
}
