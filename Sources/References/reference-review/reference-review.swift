import Primitives

public struct ReferenceReview: Sendable, Codable, Hashable, Identifiable {
    public let id: String
    public let date: PartialDate?
    public let title: String
    public let summary: ReferenceTextBlock?
    public let entries: [ReferenceReviewEntry]

    public init(
        id: String,
        date: PartialDate? = nil,
        title: String,
        summary: ReferenceTextBlock? = nil,
        entries: [ReferenceReviewEntry] = []
    ) {
        self.id = id
        self.date = date
        self.title = title
        self.summary = summary
        self.entries = entries
    }

    public var searchTerms: [String] {
        var terms = [
            id,
            date?.iso8601String,
            title,
            summary?.text,
        ]
        .compactMap { $0 }

        terms.append(contentsOf: summary?.searchTerms ?? [])
        terms.append(contentsOf: entries.flatMap(\.searchTerms))

        return terms
            .filter { !$0.isEmpty }
    }
}
