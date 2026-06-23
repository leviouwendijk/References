public struct ReferenceCollection: Sendable {
    public let sources: [any ReferenceProviding]

    public init(
        _ sources: [any ReferenceProviding]
    ) {
        self.sources = sources
    }

    public var count: Int {
        sources.count
    }

    public var deduped: [any ReferenceProviding] {
        var seen: Set<String> = []

        return sources.filter { source in
            seen.insert(source.public_name_or_id).inserted
        }
    }

    public var tags: ReferenceTagSet {
        ReferenceTagSet(
            sources.flatMap {
                $0.tags.values
            }
        )
    }

    public func section(
        _ section: ReferenceTagSection
    ) -> [any ReferenceProviding] {
        section.sources(
            from: sources
        )
    }

    public func tagged(
        _ tag: ReferenceTag
    ) -> [any ReferenceProviding] {
        sources.filter {
            $0.tags.contains(tag)
        }
    }

    public func taggedAny(
        _ tags: [ReferenceTag]
    ) -> [any ReferenceProviding] {
        sources.filter { source in
            tags.contains { tag in
                source.tags.contains(tag)
            }
        }
    }

    public func taggedAll(
        _ tags: [ReferenceTag]
    ) -> [any ReferenceProviding] {
        sources.filter { source in
            tags.allSatisfy { tag in
                source.tags.contains(tag)
            }
        }
    }
}
