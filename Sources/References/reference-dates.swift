import Primitives

public struct ReferenceDates: Sendable, Codable, Hashable {
    public let published: PartialDate?
    public let updated: PartialDate?
    public let accessed: PartialDate?

    public init(
        published: PartialDate? = nil,
        updated: PartialDate? = nil,
        accessed: PartialDate? = nil
    ) {
        self.published = published
        self.updated = updated
        self.accessed = accessed
    }

    public static func published(
        _ published: PartialDate
    ) -> ReferenceDates {
        ReferenceDates(
            published: published
        )
    }

    public static func webpage(
        published: PartialDate? = nil,
        updated: PartialDate? = nil,
        accessed: PartialDate? = nil
    ) -> ReferenceDates {
        ReferenceDates(
            published: published,
            updated: updated,
            accessed: accessed
        )
    }

    public var primary: PartialDate? {
        published ?? updated ?? accessed
    }

    public var publishedISO8601: String? {
        published?.iso8601String
    }

    public var updatedISO8601: String? {
        updated?.iso8601String
    }

    public var accessedISO8601: String? {
        accessed?.iso8601String
    }

    public var recencySortKey: Int? {
        primary?.sortKey(completion: .latest)
    }

    public var searchTerms: [String] {
        [
            publishedISO8601,
            updatedISO8601,
            accessedISO8601,
        ]
        .compactMap { $0 }
    }
}
