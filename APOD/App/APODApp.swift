//
//  APODApp.swift
//  APOD
//
//  Created by Michael Haß on 05.07.25.
//

import SwiftUI

@main
struct APODApp: App {
    let astronomyMedia: AstronomyMedia
    let error: APODErrorModel

    init() {
        self.astronomyMedia = .init(mediaService: .createDefault(environment: .default))
        self.error = .init()
    }

    var body: some Scene {
        WindowGroup {
            MainTabView(initialTab: .apod, contentProviders: [
                HomeTabContentProvider(),
                AboutTabContentProvider()
            ])
            .environmentObject(astronomyMedia)
            .environmentObject(error)
        }
    }
}
