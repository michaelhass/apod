//
//  MediaOfTheDayPage.swift
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

    var formattedMediaEntry: MediaEntryTextFormatter? {
        astronomyMedia.mediaOfTheDay.map { MediaEntryTextFormatter(mediaEntry: $0) }
    }

    var body: some View {
        ZStack {
            imageView(for: astronomyMedia.mediaOfTheDay?.url)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .topTrailing) {
            mediaOverlay(mediaEntry: formattedMediaEntry)
        }
        .sheet(isPresented: $isPresentingInformation, content: {
            if let mediaEntry = astronomyMedia.mediaOfTheDay {
                MediaEntryInfoSheet(mediaEntry: mediaEntry)
           } else {
                EmptyView()
            }
        })
        .task {
            guard astronomyMedia.mediaOfTheDay == nil else { return }
            try? await astronomyMedia.fetchMediaOfTheDay()
        }

    }

    @ViewBuilder
    func mediaOverlay(mediaEntry: MediaEntryTextFormatter?) -> some View {
        if let mediaEntry {
            VStack(alignment: .leading) {
                Text(mediaEntry.title)
                    .lineLimit(1)
                    .font(.title)
                    .foregroundStyle(Color.titleText)

                HStack {
                    Button(action: {}) {
                        Text(mediaEntry.date)
                            .font(.body)
                            .padding(4)
                    }
                    .foregroundStyle(Color.primaryActionText)
                    .background(Color.primaryAction)
                    .clipShape(RoundedRectangle(cornerRadius: 4))

                    Spacer()

                    Button(action: { isPresentingInformation.toggle() }) {
                        Image(systemName: "info.circle")
                            .dynamicTypeSize(DynamicTypeSize.large...DynamicTypeSize.accessibility1)
                    }
                    .padding(4)
                    .foregroundStyle(Color.primaryActionText)
                    .background(Color.primaryAction)
                    .clipShape(Circle())
                }
            }
            .padding()
            .background {
                Color.background.opacity(0.3)
            }
        } else {
            EmptyView()
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
        .zoomable()
    }
}
