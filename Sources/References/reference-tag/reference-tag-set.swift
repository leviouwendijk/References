public struct ReferenceTagSet: Sendable, Codable, Hashable {
    public let values: [ReferenceTag]

    public init(
        _ values: [ReferenceTag] = []
    ) {
        var seen: Set<String> = []
        var deduped: [ReferenceTag] = []

        for value in values {
            if seen.insert(value.id).inserted {
                deduped.append(value)
            }
        }

        self.values = deduped
    }

    public var isEmpty: Bool {
        values.isEmpty
    }

    public var ids: [String] {
        values.map(\.id)
    }

    public var keys: [String] {
        values.map(\.key)
    }

    public func contains(
        _ tag: ReferenceTag
    ) -> Bool {
        ids.contains(tag.id)
    }

    public func contains(
        id: String
    ) -> Bool {
        ids.contains(id.normalizedReferenceTagID)
    }

    public func contains(
        namespace: String,
        key: String
    ) -> Bool {
        contains(
            id: "\(namespace.normalizedReferenceKey):\(key.normalizedReferenceKey)"
        )
    }

    public func matching(
        namespace: String
    ) -> [ReferenceTag] {
        let normalized = namespace.normalizedReferenceKey

        return values.filter {
            $0.namespace == normalized
        }
    }

    public func adding(
        _ tags: [ReferenceTag]
    ) -> ReferenceTagSet {
        ReferenceTagSet(
            values + tags
        )
    }

    public var searchTerms: [String] {
        Array(
            Set(
                values.flatMap(\.searchTerms)
            )
        )
        .sorted()
    }
}

public extension String {
    var normalizedReferenceTagID: String {
        let parts = split(
            separator: ":",
            maxSplits: 1,
            omittingEmptySubsequences: true
        )

        if parts.count == 2 {
            return "\(String(parts[0]).normalizedReferenceKey):\(String(parts[1]).normalizedReferenceKey)"
        }

        return normalizedReferenceKey
    }
}
