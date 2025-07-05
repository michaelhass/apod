//
//  MediaOfThePage.swift
//  APOD
//
//  Created by Michael Haß on 05.07.25.
//

import SwiftUI

struct MediaOfTheDayPage: View {
    @EnvironmentObject
    private var astronomyMedia: AstronomyMedia

    @State
    private var isPresentingInformation: Bool = false

    var body: some View {
        ZStack {
            imageView(for: astronomyMedia.mediaOfTheDay?.url)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .topTrailing) {
            Button(action: { isPresentingInformation.toggle() }) {
                Text("Click me")
            }

        }
        .sheet(isPresented: $isPresentingInformation, content: {
            if let media = astronomyMedia.mediaOfTheDay {
                ScrollView {
                    Text(media.explanation)
                }
                .padding(.top, 32)
                .presentationDragIndicator(.visible)
                .presentationDetents([.medium])
                .presentationBackground(.thinMaterial)
            } else {
                EmptyView()
            }
        })
        .task {
            guard astronomyMedia.mediaOfTheDay == nil else { return }
            try? await astronomyMedia.fetchMediaOfTheDay()
        }
    }

    func imageView(for url: URL?) -> some View {
        AsyncImage(url: url) { image in
            if let image = image.image {
                image
                    .resizable()
                    .scaledToFit()
            } else {
                StarProgressView(size: .large)
            }
        }
    }
}
