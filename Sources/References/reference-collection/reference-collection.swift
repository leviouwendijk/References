public struct ReferenceCollection: Sendable {
    public let items: [any ReferenceProviding]

    public init(
        _ items: [any ReferenceProviding]
    ) {
        self.items = items
    }

    public var count: Int {
        items.count
    }

    public var deduped: [any ReferenceProviding] {
        var seen: Set<String> = []

        return items.filter { item in
            seen.insert(item.public_name_or_id).inserted
        }
    }

    public var tags: ReferenceTagSet {
        ReferenceTagSet(
            items.flatMap {
                $0.tags.values
            }
        )
    }

    public func section(
        _ section: ReferenceTagSection
    ) -> [any ReferenceProviding] {
        section.items(
            from: items
        )
    }

    public func tagged(
        _ tag: ReferenceTag
    ) -> [any ReferenceProviding] {
        items.filter {
            $0.tags.contains(tag)
        }
    }

    public func matching(
        tags: [ReferenceTag],
        match: ReferenceTagMatch = .any
    ) -> [any ReferenceProviding] {
        guard !tags.isEmpty else {
            return items
        }

        switch match {
        case .any:
            return items.filter { item in
                tags.contains { tag in
                    item.tags.contains(tag)
                }
            }

        case .all:
            return items.filter { item in
                tags.allSatisfy { tag in
                    item.tags.contains(tag)
                }
            }
        }
    }
}
