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
    @State
    private var selectedDate: Date?

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
        .task(id: selectedDate) {
            guard let selectedDate else {
                selectedDate = astronomyMedia.mediaOfTheDay?.date ?? .now
                return
            }
            let mediaOfTheDayDate = astronomyMedia.mediaOfTheDay?.date ?? .distantFuture
            guard !selectedDate.isInSameDayAs(mediaOfTheDayDate) else { return }
            try? await astronomyMedia.fetchMedia(for: selectedDate)
        }
    }

    @ViewBuilder
    func mediaOverlay(mediaEntry: MediaEntryTextFormatter?) -> some View {
        if let mediaEntry {
            VStack(alignment: .leading, spacing: .verticalContentSpacing) {
                Text(mediaEntry.title)
                    .lineLimit(1)
                    .font(.title)
                    .foregroundStyle(Color.titleText)

                HStack {
                    Spacer()

                    DatePicker(
                        "",
                        selection: .init(
                            get: { selectedDate ?? .now },
                            set: { selectedDate = $0 }
                        ),
                        in: ...Date.now,
                        displayedComponents: [.date]
                    )

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
            .pageTopPadding()
            .horizontalContentPadding()
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
