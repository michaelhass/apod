import Foundation

struct APODEnvironment {
    private(set) var baseURL: URL
    private(set) var prefixPath: String
    private(set) var apiKey: String?
}

extension APODEnvironment {
    static func prod(apiKey: String?) -> Self {
        .init(
            baseURL: URL(string: "https://api.nasa.gov")!,
            prefixPath: "/planetary/apod",
            apiKey: apiKey
        )
    }

    static var debug: APODEnvironment {
        .prod(apiKey: "DEMO_KEY")
    }
}
