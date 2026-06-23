import Primitives

public typealias Referencable = ReferenceProviding

public protocol ReferenceProviding:
    Sendable,
    Codable,
    CaseIterable,
    RawRepresentable
where RawValue == String {
    var public_name_or_id: String { get }
    var data: ReferenceData { get }

    var title: String { get }
    var location: ReferenceURL { get }
    var url: String { get }
    var source: ReferenceSource? { get }
    var sourceKey: String? { get }
    var sourceLabel: String? { get }
    var sourceHost: String? { get }
    var authors: ReferenceAuthors? { get }
    var authorLine: String? { get }
    var authorKeys: [String] { get }
    var authorFamilyKeys: [String] { get }
    var dates: ReferenceDates { get }
    var date: PartialDate? { get }
    var dateISO8601: String? { get }
    var updatedISO8601: String? { get }
    var accessedISO8601: String? { get }
    var container: ReferenceContainer? { get }
    var doi: String? { get }
    var kind: ReferenceKind { get }
    var channel: ReferenceChannel { get }
    var abstract: ReferenceTextBlock? { get }
    var abstractText: String? { get }
    var notes: [ReferenceTextBlock] { get }
    var relations: [ReferenceRelation] { get }
    var tags: ReferenceTagSet { get }
    var recencySortKey: Int? { get }
    var searchTerms: [String] { get }
}

public extension ReferenceProviding {
    var public_name_or_id: String {
        rawValue
    }

    var title: String {
        data.title
    }

    var location: ReferenceURL {
        data.location
    }

    var url: String {
        data.url
    }

    var source: ReferenceSource? {
        data.source
    }

    var sourceKey: String? {
        data.sourceKey
    }

    var sourceLabel: String? {
        data.sourceLabel
    }

    var sourceHost: String? {
        data.sourceHost
    }

    var authors: ReferenceAuthors? {
        data.authors
    }

    var authorLine: String? {
        data.authorLine
    }

    var authorKeys: [String] {
        data.authorKeys
    }

    var authorFamilyKeys: [String] {
        data.authorFamilyKeys
    }

    var dates: ReferenceDates {
        data.dates
    }

    var date: PartialDate? {
        data.date
    }

    var dateISO8601: String? {
        data.dateISO8601
    }

    var updatedISO8601: String? {
        data.updatedISO8601
    }

    var accessedISO8601: String? {
        data.accessedISO8601
    }

    var container: ReferenceContainer? {
        data.container
    }

    var doi: String? {
        data.doi
    }

    var kind: ReferenceKind {
        data.kind
    }

    var channel: ReferenceChannel {
        data.channel
    }

    var abstract: ReferenceTextBlock? {
        data.abstract
    }

    var abstractText: String? {
        data.abstractText
    }

    var notes: [ReferenceTextBlock] {
        data.notes
    }

    var relations: [ReferenceRelation] {
        data.relations
    }

    var tags: ReferenceTagSet {
        data.tags
    }

    var recencySortKey: Int? {
        data.recencySortKey
    }

    var searchTerms: [String] {
        data.searchTerms
    }

    func formatted(
        _ style: ReferenceFormatStyle = .compact
    ) -> String {
        data.formatted(style)
    }
}
