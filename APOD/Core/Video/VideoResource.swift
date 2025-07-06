//
//  VideoResource.swift
//  APOD
//
//  Created by Michael Haß on 06.07.25.
//

import Foundation
import AVKit

struct VideoResource {
    let url: URL
    let isWebVideo: Bool
    let player: AVPlayer?

    init(url: URL) {
        self.url = url
        self.isWebVideo = url.isWebVideoResource
        self.player = isWebVideo ? nil : .init(url: url)
    }

    init?(urlString: String) {
        guard let url = URL(string: urlString) else {
            return nil
        }
        self.init(url: url)
    }
}
