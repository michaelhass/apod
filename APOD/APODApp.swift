//
//  APODApp.swift
//  APOD
//
//  Created by Michael Haß on 05.07.25.
//

import SwiftUI

@main
struct APODApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView(availableTabs: MainTab.allCases)
        }
    }
}
