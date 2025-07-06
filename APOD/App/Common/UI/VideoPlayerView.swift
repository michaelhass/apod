//
//  VideoPlayerView.swift
//  APOD
//
//  Created by Michael Haß on 06.07.25.
//

import SwiftUI
import AVKit
import WebKit

struct VideoPlayerView: View {
    let videoResource: VideoResource

    var body: some View {
        Group {
            if videoResource.isWebVideo {
                WebPlayerView(url: videoResource.url)
                    .frame(maxWidth: .infinity)
                    .aspectRatio(16/9, contentMode: .fit)
            } else if let player = videoResource.player {
                VideoPlayer(player: player)
            } else {
                EmptyView()
            }
        }
        .id(videoResource.url)
    }
}

private struct WebPlayerView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.load(URLRequest(url: url))
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        webView.load(URLRequest(url: url))
    }

    func makeCoordinator() -> WebPlayerCoordinator {
        .init()
    }
}

private final class WebPlayerCoordinator: NSObject, WKNavigationDelegate {

    private(set) var didFinishLoading: Bool = false


    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        didFinishLoading = true
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction) async -> WKNavigationActionPolicy {
        .allow
    }
}

#Preview {
    let urlString = "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
//    let urlString = "https://www.youtube.com/embed/CC7OJ7gFLvE?rel=0"
    let resource = VideoResource(urlString: urlString)!
    return ZStack {
        Color.green
        VideoPlayerView(videoResource: resource)
    }
}
