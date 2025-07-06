import Foundation

struct AstronomyMediaEnvironment {
    private(set) var baseURL: URL
    private(set) var prefixPath: String
    private(set) var apiKey: String?
}

extension AstronomyMediaEnvironment {
    static func prod(apiKey: String?) -> Self {
        .init(
            baseURL: URL(string: "https://api.nasa.gov")!,
            prefixPath: "/planetary/apod",
            apiKey: apiKey
        )
    }

    static var debug: AstronomyMediaEnvironment {
        .prod(apiKey: "DEMO_KEY")
    }
}

extension AstronomyMediaEnvironment {
    static var `default`: AstronomyMediaEnvironment {
#if DEBUG
        return .debug
#else
        return .prod(apiKey: "CHANGE_ME")
#endif
    }
}
