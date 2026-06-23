public struct ReferenceSource: Sendable, Codable, Hashable {
    public let key: String
    public let label: String
    public let host: String?

    public init(
        key: String,
        label: String,
        host: String? = nil
    ) {
        self.key = key.normalizedReferenceKey
        self.label = label
        self.host = host
    }

    public init?(
        url: ReferenceURL
    ) {
        guard
            let key = url.sourceKey,
            let label = url.sourceLabel
        else {
            return nil
        }

        self.key = key
        self.label = label
        self.host = url.normalizedHost
    }
}

