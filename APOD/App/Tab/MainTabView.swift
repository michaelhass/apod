//
//  MainTabView.swift
//  APOD
//
//  Created by Michael Haß on 05.07.25.
//

import SwiftUI

enum MainTab: CaseIterable {
    case apod
    case about

    var systemImageName: String {
        switch self {
        case .apod: "star"
        case .about: "questionmark.circle"
        }
    }
}

@MainActor
protocol MainTabContentProvider {
    var tab: MainTab { get }

    associatedtype Content: View

    @ViewBuilder
    func content() -> Content
}

struct MainTabView: View {
    @State
    private var selectedTab: MainTab
    private let availableTabs: [MainTab]
    private let contentProviders: [any MainTabContentProvider]

    init(initialTab: MainTab, contentProviders: [any MainTabContentProvider]) {
        self.selectedTab = initialTab
        self.availableTabs = contentProviders.compactMap(\.tab)
        self.contentProviders = contentProviders
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                ForEach(availableTabs, id: \.self) { tab in
                    content(for: tab)
                        .id(selectedTab)
               }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))

            MainTabBar(availableTabs: availableTabs, selectedTab: $selectedTab)
        }
        .background(Color.background)
    }

    @ViewBuilder
    func content(for tab: MainTab) -> some View {
        if let provider = contentProviders.first(where: { $0.tab == tab }) {
            AnyView(provider.content())
        } else {
            EmptyView()
        }

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
                Color.gray
                    .blur(radius: 12)
                    .frame(height: reader.size.height - 8)
                    .frame(maxWidth: .infinity)
                    .background(.thickMaterial)
                    .clipShape(Capsule())
                    .opacity(0.4)
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
        Image(
            systemName: tab.systemImageName
        )
        .dynamicTypeSize(DynamicTypeSize.xxLarge...DynamicTypeSize.accessibility3)
    }

}
