//
//  MediaEntryInfoSheet.swift
//  APOD
//
//  Created by Michael Haß on 05.07.25.
//

import SwiftUI

struct MediaEntryTextFormatter {
    let title: String
    let date: String
    let explanation: String
    let copyright: String?

    static var dateFormatter: DateFormatter {
        .medium
    }

    init(mediaEntry: AstronomyMediaEntry) {
        self.title = mediaEntry.title
        self.date = Self.dateFormatter.string(from: mediaEntry.date)
        self.explanation = mediaEntry.explanation
        self.copyright = mediaEntry.copyright?.removedLineBreaks
    }
}

struct MediaEntryInfoSheet: View {
    let mediaEntry: MediaEntryTextFormatter

    init(mediaEntry: AstronomyMediaEntry) {
        self.mediaEntry = .init(mediaEntry: mediaEntry)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: .verticalContentSpacing) {
                Text(mediaEntry.date)
                    .font(.callout)
                    .foregroundStyle(Color.secondaryText)
                    .aligned(.trailing)

                Text(mediaEntry.title)
                    .font(.title)
                    .foregroundStyle(Color.titleText)
                    .aligned(.leading)

                Text(mediaEntry.explanation)
                    .font(.body)
                    .foregroundStyle(Color.secondaryText)
                    .aligned(.leading)

                if let copyright = mediaEntry.copyright {
                    Text(copyright)
                        .font(.caption)
                        .foregroundStyle(Color.secondaryText)
                        .aligned(.leading)
                }

            }
            .horizontalContentPadding()
        }
        .defaultSheetStyle()
    }
}

#Preview {
    Color.background
        .sheet(isPresented: .constant(true), content: {
            MediaEntryInfoSheet(
                mediaEntry: .init(
                    title: "Title",
                    url: URL(string: "https://duckduckgo.com")!,
                    date: .now,
                    mediaType: "",
                    explanation: "Hello this is a longer text",
                    copyright: "Copright \n text"
                )
            )
        }
    )
}
