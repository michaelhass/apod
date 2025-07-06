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

    init() {
        #if DEBUG
        let environment: APODEnvironment = .debug
        #else
        let environment: APODEnvironment = .prod(apiKey: "n6dYAadR3p9kGn4UDQcM4JNo5BKrYOl8tQlvTAcg")
        #endif

        self.astronomyMedia = .init(mediaService: .createDefault(environment: environment))
    }

    var body: some Scene {
        WindowGroup {
            MainTabView(initialTab: .apod, contentProviders: [
                HomeTabContentProvider(),
                AboutTabContentProvider()
            ])
            .environmentObject(astronomyMedia)
        }
    }
}
