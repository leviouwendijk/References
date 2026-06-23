public struct ReferenceTagSection: Sendable, Codable, Hashable {
    public let id: String
    public let title: String
    public let eyebrow: String?
    public let caption: String?
    public let include: ReferenceTagSet
    public let exclude: ReferenceTagSet
    public let match: ReferenceTagMatch
    public let sort: ReferenceSort
    public let dedupe: Bool

    public init(
        id: String,
        title: String,
        eyebrow: String? = nil,
        caption: String? = nil,
        include: ReferenceTagSet = ReferenceTagSet(),
        exclude: ReferenceTagSet = ReferenceTagSet(),
        match: ReferenceTagMatch = .any,
        sort: ReferenceSort = .declaration_order,
        dedupe: Bool = true
    ) {
        self.id = id.normalizedReferenceKey
        self.title = title
        self.eyebrow = eyebrow
        self.caption = caption
        self.include = include
        self.exclude = exclude
        self.match = match
        self.sort = sort
        self.dedupe = dedupe
    }

    public init(
        id: String,
        title: String,
        eyebrow: String? = nil,
        caption: String? = nil,
        include: [ReferenceTag],
        exclude: [ReferenceTag] = [],
        match: ReferenceTagMatch = .any,
        sort: ReferenceSort = .declaration_order,
        dedupe: Bool = true
    ) {
        self.init(
            id: id,
            title: title,
            eyebrow: eyebrow,
            caption: caption,
            include: ReferenceTagSet(include),
            exclude: ReferenceTagSet(exclude),
            match: match,
            sort: sort,
            dedupe: dedupe
        )
    }

    public func matches(
        _ item: any ReferenceProviding
    ) -> Bool {
        let included = include.isEmpty || includes(item)
        let excluded = exclude.values.contains { tag in
            item.tags.contains(tag)
        }

        return included && !excluded
    }

    public func items(
        from items: [any ReferenceProviding]
    ) -> [any ReferenceProviding] {
        let matched = items.filter {
            matches($0)
        }

        let deduped = dedupe
            ? dedupedItems(matched)
            : matched

        return ordered(deduped)
    }

    private func includes(
        _ item: any ReferenceProviding
    ) -> Bool {
        switch match {
        case .any:
            return include.values.contains { tag in
                item.tags.contains(tag)
            }

        case .all:
            return include.values.allSatisfy { tag in
                item.tags.contains(tag)
            }
        }
    }

    private func dedupedItems(
        _ items: [any ReferenceProviding]
    ) -> [any ReferenceProviding] {
        var seen: Set<String> = []

        return items.filter { item in
            seen.insert(item.public_name_or_id).inserted
        }
    }

    private func ordered(
        _ items: [any ReferenceProviding]
    ) -> [any ReferenceProviding] {
        switch sort {
        case .declaration_order:
            return items

        case .title_ascending:
            return items.sorted {
                $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending
            }

        case .date_newest:
            return items.sorted {
                key($0) > key($1)
            }

        case .date_oldest:
            return items.sorted {
                key($0) < key($1)
            }
        }
    }

    private func key(
        _ item: any ReferenceProviding
    ) -> Int {
        item.recencySortKey ?? 0
    }
}
