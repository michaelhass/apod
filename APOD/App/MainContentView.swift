//
//  MainContentView.swift
//  APOD
//
//  Created by Michael Haß on 05.07.25.
//

import SwiftUI

struct MainContentView: View {
    var body: some View {
        MainTabView(initialTab: .apod, contentProviders: [
            HomeTabContentProvider(),
            AboutTabContentProvider()
        ])
    }
}

