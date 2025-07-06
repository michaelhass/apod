//
//  URL+VideoResource.swift
//  APOD
//
//  Created by Michael Haß on 06.07.25.
//

import Foundation

extension URL {
    static var webVideoResourceHosts: [String]  {
        ["youtube", "vimeo"]
    }

    var isWebVideoResource: Bool {
        Self.webVideoResourceHosts.contains {
            self.host?.contains($0) == true
        }
    }
}
