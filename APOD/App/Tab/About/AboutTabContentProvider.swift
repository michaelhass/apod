//
//  AboutTabContentProvider.swift
//  APOD
//
//  Created by Michael Haß on 05.07.25.
//

import SwiftUI

struct AboutTabContentProvider: MainTabContentProvider {
    let tab: MainTab = .about

    func content() -> some View {
        AboutPage()
    }
}
