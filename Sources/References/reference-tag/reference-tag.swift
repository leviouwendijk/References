public struct ReferenceTag: Sendable, Codable, Hashable {
    public let namespace: String
    public let key: String
    public let label: String

    public init(
        namespace: String,
        key: String,
        label: String
    ) {
        self.namespace = namespace.normalizedReferenceKey
        self.key = key.normalizedReferenceKey
        self.label = label
    }

    public init(
        _ id: String,
        label: String
    ) {
        let parts = id.split(
            separator: ":",
            maxSplits: 1,
            omittingEmptySubsequences: true
        )

        if parts.count == 2 {
            self.init(
                namespace: String(parts[0]),
                key: String(parts[1]),
                label: label
            )
        } else {
            self.init(
                namespace: "reference",
                key: id,
                label: label
            )
        }
    }

    public var id: String {
        "\(namespace):\(key)"
    }

    public var searchTerms: [String] {
        [
            id,
            namespace,
            key,
            label,
        ]
        .filter { !$0.isEmpty }
    }
}
