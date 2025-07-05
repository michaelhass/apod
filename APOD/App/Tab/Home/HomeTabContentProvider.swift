//
//  HomeTabContentProvider.swift
//  APOD
//
//  Created by Michael Haß on 05.07.25.
//

import SwiftUI

struct HomeTabContentProvider: MainTabContentProvider {
    let tab: MainTab = .apod

    func content() -> some View {
        MediaOfTheDayPage()
    }
}
