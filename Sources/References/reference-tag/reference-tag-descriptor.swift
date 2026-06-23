public struct ReferenceTagDescriptor: Sendable, Codable, Hashable {
    public let tag: ReferenceTag
    public let shortLabel: String?
    public let caption: String?
    public let related: ReferenceTagSet

    public init(
        tag: ReferenceTag,
        shortLabel: String? = nil,
        caption: String? = nil,
        related: ReferenceTagSet = ReferenceTagSet()
    ) {
        self.tag = tag
        self.shortLabel = shortLabel
        self.caption = caption
        self.related = related
    }

    public var id: String {
        tag.id
    }

    public var label: String {
        shortLabel ?? tag.label
    }

    public var searchTerms: [String] {
        var terms = tag.searchTerms

        if let shortLabel, !shortLabel.isEmpty {
            terms.append(shortLabel)
        }

        if let caption, !caption.isEmpty {
            terms.append(caption)
        }

        terms.append(contentsOf: related.searchTerms)

        return Array(Set(terms))
            .sorted()
    }
}
