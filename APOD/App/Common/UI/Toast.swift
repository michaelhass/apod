//
//  Toast.swift
//  APOD
//
//  Created by Michael Haß on 06.07.25.
//

import SwiftUI

struct Toast: View {
    let message: String

    var body: some View {
        Text(LocalizedStringKey(message))
            .frame(minWidth: 140)
            .lineLimit(1)
            .foregroundStyle(.secondaryActionText)
            .padding(16)
            .background(Color.secondaryAction)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .horizontalContentPadding()
    }
}

struct ShowToastViewModifier: ViewModifier {
    @Binding
    var message: String?

    func body(content: Content) -> some View {
        content
            .overlay(alignment: .top) {
                if let message {
                    Toast(message: message)
                        .padding(.top)
                        .transition(.opacity.combined(with:.move(edge: .top)))
                        .task {
                            try? await Task.sleep(for: .seconds(3))
                            self.message = nil
                        }
                } else {
                    EmptyView()
                }
            }
            .animation(.spring, value: message)
    }
}

extension View {
    func showToast(_ message: Binding<String?>) -> some View {
        self.modifier(ShowToastViewModifier(message: message))
    }
}

#Preview {
    struct TestView: View {
        @State
        var message: String?

        var body: some View {
            Color.clear
                .showToast($message)
                .onAppear {
                    message = "An error occured"
                }
        }
    }
    return TestView()
        .environment(\.locale, Locale(identifier: "de"))
}
