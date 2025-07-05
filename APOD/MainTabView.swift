//
//  MainTabView.swift
//  APOD
//
//  Created by Michael Haß on 05.07.25.
//

import SwiftUI

enum MainTab: CaseIterable {
    case apod
    case info
}

struct MainTabView: View {
    let availableTabs: [MainTab]
    @State
    private var selectedTab: MainTab = .apod

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                ForEach(availableTabs, id: \.self) { tab in
                    Text("\(tab)")
                        .foregroundStyle(Color.primaryText)
                }
                .id(selectedTab)
            }

            MainTabBar(availableTabs: availableTabs, selectedTab: $selectedTab)
        }
        .background(Color.background)
    }
}

struct MainTabBar: View {
    @Namespace
    private var namespace
    let availableTabs: [MainTab]
    @Binding
    private(set) var selectedTab: MainTab

    var body: some View {
        HStack(spacing: 8) {
            ForEach(availableTabs, id: \.self) { tab in
                if selectedTab == tab {
                    selectedItem(for: tab)
                        .matchedGeometryEffect(id: "tabitem.selected", in: namespace)
                } else {
                    tabItem(for: tab)
                }
            }
        }
        .padding(.horizontal)
        .background(
            GeometryReader { reader in
                Color.gray.opacity(0.4)
                    .frame(height: reader.size.height - 8)
                    .frame(maxWidth: .infinity)
                    .clipShape(Capsule())
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        )
        .animation(.default, value: selectedTab)
    }

    func tabItem(for tab: MainTab) -> some View {
        Button {
            selectedTab = tab
        } label: {
            icon(for: tab)
                .padding(8)
                .tint(Color.primaryActionText)
        }
        .clipShape(Circle())
    }

    func selectedItem(for tab:  MainTab) -> some View {
        Button {
            selectedTab = tab
        } label: {
            icon(for: tab)
                .scaleEffect(1.15)
                .padding(8)
                .tint(Color.primaryActionText)
        }
        .background(Color.primaryAction)
        .clipShape(Circle())
    }

    func icon(for tab: MainTab) -> some View {
        let image = switch tab {
        case .apod: Image(systemName: "star")
        case .info: Image(systemName: "info.circle")
        }
        return image .dynamicTypeSize(DynamicTypeSize.xxLarge...DynamicTypeSize.accessibility3)
    }

}

#Preview {
    MainTabView(availableTabs: MainTab.allCases)
}
