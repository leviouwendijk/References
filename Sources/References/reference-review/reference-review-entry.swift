public struct ReferenceReviewEntry: Sendable, Codable, Hashable, Identifiable {
    public let id: String
    public let kind: ReferenceReviewEntryKind
    public let title: String?
    public let body: ReferenceTextBlock

    public init(
        id: String,
        kind: ReferenceReviewEntryKind,
        title: String? = nil,
        body: ReferenceTextBlock
    ) {
        self.id = id
        self.kind = kind
        self.title = title
        self.body = body
    }

    public var searchTerms: [String] {
        [
            id,
            kind.rawValue,
            kind.label,
            kind.dutch,
            title,
        ]
        .compactMap { $0 }
        + body.searchTerms
    }
}
