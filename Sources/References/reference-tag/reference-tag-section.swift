public struct ReferenceTagSection: Sendable, Codable, Hashable {
    public let id: String
    public let title: String
    public let eyebrow: String?
    public let caption: String?
    public let include: ReferenceTagSet
    public let exclude: ReferenceTagSet
    public let matchMode: ReferenceTagSectionMatchMode
    public let sortOrder: ReferenceSortOrder
    public let dedupe: Bool

    public init(
        id: String,
        title: String,
        eyebrow: String? = nil,
        caption: String? = nil,
        include: ReferenceTagSet = ReferenceTagSet(),
        exclude: ReferenceTagSet = ReferenceTagSet(),
        matchMode: ReferenceTagSectionMatchMode = .any,
        sortOrder: ReferenceSortOrder = .declaration_order,
        dedupe: Bool = true
    ) {
        self.id = id.normalizedReferenceKey
        self.title = title
        self.eyebrow = eyebrow
        self.caption = caption
        self.include = include
        self.exclude = exclude
        self.matchMode = matchMode
        self.sortOrder = sortOrder
        self.dedupe = dedupe
    }

    public init(
        id: String,
        title: String,
        eyebrow: String? = nil,
        caption: String? = nil,
        include: [ReferenceTag],
        exclude: [ReferenceTag] = [],
        matchMode: ReferenceTagSectionMatchMode = .any,
        sortOrder: ReferenceSortOrder = .declaration_order,
        dedupe: Bool = true
    ) {
        self.init(
            id: id,
            title: title,
            eyebrow: eyebrow,
            caption: caption,
            include: ReferenceTagSet(include),
            exclude: ReferenceTagSet(exclude),
            matchMode: matchMode,
            sortOrder: sortOrder,
            dedupe: dedupe
        )
    }

    public func matches(
        _ reference: any ReferenceProviding
    ) -> Bool {
        let included = include.isEmpty || includeMatches(reference)
        let excluded = exclude.values.contains { tag in
            reference.tags.contains(tag)
        }

        return included && !excluded
    }

    public func sources(
        from references: [any ReferenceProviding]
    ) -> [any ReferenceProviding] {
        let matched = references.filter {
            matches($0)
        }

        let deduped = dedupe
            ? dedupeSources(matched)
            : matched

        return sort(deduped)
    }

    private func includeMatches(
        _ reference: any ReferenceProviding
    ) -> Bool {
        switch matchMode {
        case .any:
            return include.values.contains { tag in
                reference.tags.contains(tag)
            }

        case .all:
            return include.values.allSatisfy { tag in
                reference.tags.contains(tag)
            }
        }
    }

    private func dedupeSources(
        _ sources: [any ReferenceProviding]
    ) -> [any ReferenceProviding] {
        var seen: Set<String> = []

        return sources.filter { source in
            seen.insert(source.public_name_or_id).inserted
        }
    }

    private func sort(
        _ sources: [any ReferenceProviding]
    ) -> [any ReferenceProviding] {
        switch sortOrder {
        case .declaration_order:
            return sources

        case .title_ascending:
            return sources.sorted {
                $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending
            }

        case .date_newest:
            return sources.sorted {
                sortKey($0) > sortKey($1)
            }

        case .date_oldest:
            return sources.sorted {
                sortKey($0) < sortKey($1)
            }
        }
    }

    private func sortKey(
        _ source: any ReferenceProviding
    ) -> Int {
        source.recencySortKey ?? 0
    }
}
