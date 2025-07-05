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
        ScrollView {
            VStack {
                ForEach((0..<100), content: { index in
                    Text("\(index)").frame(height: 50)
                })
            }
        }
    }
}
