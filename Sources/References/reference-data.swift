import Primitives

public struct ReferenceData: Sendable, Codable, Hashable {
    public let title: String
    public let location: ReferenceURL
    public let source: ReferenceSource?
    public let authors: ReferenceAuthors?
    public let dates: ReferenceDates
    public let container: ReferenceContainer?
    public let doi: String?
    public let kind: ReferenceKind
    public let channel: ReferenceChannel
    public let abstract: ReferenceTextBlock?
    public let notes: [ReferenceTextBlock]
    public let reviews: [ReferenceReview]
    public let relations: [ReferenceRelation]
    public let tags: ReferenceTagSet

    public init(
        title: String,
        location: ReferenceURL,
        source: ReferenceSource? = nil,
        authors: ReferenceAuthors? = nil,
        dates: ReferenceDates = ReferenceDates(),
        container: ReferenceContainer? = nil,
        doi: String? = nil,
        kind: ReferenceKind = .other,
        channel: ReferenceChannel = .unknown,
        abstract: ReferenceTextBlock? = nil,
        notes: [ReferenceTextBlock] = [],
        reviews: [ReferenceReview] = [],
        relations: [ReferenceRelation] = [],
        tags: ReferenceTagSet = ReferenceTagSet()
    ) {
        self.title = title
        self.location = location
        self.source = source ?? ReferenceSource(url: location)
        self.authors = authors
        self.dates = dates
        self.container = container
        self.doi = doi
        self.kind = kind
        self.channel = channel
        self.abstract = abstract
        self.notes = notes
        self.reviews = reviews
        self.relations = relations
        self.tags = tags
    }

    public init(
        title: String,
        location: ReferenceURL,
        source: ReferenceSource? = nil,
        authors: ReferenceAuthors? = nil,
        date: PartialDate?,
        container: ReferenceContainer? = nil,
        doi: String? = nil,
        kind: ReferenceKind = .other,
        channel: ReferenceChannel = .unknown,
        abstract: ReferenceTextBlock? = nil,
        notes: [ReferenceTextBlock] = [],
        reviews: [ReferenceReview] = [],
        relations: [ReferenceRelation] = [],
        tags: ReferenceTagSet = ReferenceTagSet()
    ) {
        self.init(
            title: title,
            location: location,
            source: source,
            authors: authors,
            dates: ReferenceDates(
                published: date
            ),
            container: container,
            doi: doi,
            kind: kind,
            channel: channel,
            abstract: abstract,
            notes: notes,
            reviews: reviews,
            relations: relations,
            tags: tags
        )
    }

    public init(
        title: String,
        source: ReferenceSource,
        path: String,
        authors: ReferenceAuthors? = nil,
        dates: ReferenceDates = ReferenceDates(),
        container: ReferenceContainer? = nil,
        doi: String? = nil,
        kind: ReferenceKind = .other,
        channel: ReferenceChannel = .unknown,
        abstract: ReferenceTextBlock? = nil,
        notes: [ReferenceTextBlock] = [],
        reviews: [ReferenceReview] = [],
        relations: [ReferenceRelation] = [],
        tags: ReferenceTagSet = ReferenceTagSet()
    ) {
        self.init(
            title: title,
            location: source.url(path),
            source: source,
            authors: authors,
            dates: dates,
            container: container,
            doi: doi,
            kind: kind,
            channel: channel,
            abstract: abstract,
            notes: notes,
            reviews: reviews,
            relations: relations,
            tags: tags
        )
    }

    public init(
        title: String,
        url: String,
        source: ReferenceSource? = nil,
        authors: ReferenceAuthors? = nil,
        dates: ReferenceDates = ReferenceDates(),
        container: ReferenceContainer? = nil,
        doi: String? = nil,
        kind: ReferenceKind = .other,
        channel: ReferenceChannel = .unknown,
        abstract: ReferenceTextBlock? = nil,
        notes: [ReferenceTextBlock] = [],
        reviews: [ReferenceReview] = [],
        relations: [ReferenceRelation] = [],
        tags: ReferenceTagSet = ReferenceTagSet()
    ) {
        self.init(
            title: title,
            location: ReferenceURL(url),
            source: source,
            authors: authors,
            dates: dates,
            container: container,
            doi: doi,
            kind: kind,
            channel: channel,
            abstract: abstract,
            notes: notes,
            reviews: reviews,
            relations: relations,
            tags: tags
        )
    }

    public init(
        title: String,
        url: String,
        source: ReferenceSource? = nil,
        authors: ReferenceAuthors? = nil,
        date: PartialDate?,
        container: ReferenceContainer? = nil,
        doi: String? = nil,
        kind: ReferenceKind = .other,
        channel: ReferenceChannel = .unknown,
        abstract: ReferenceTextBlock? = nil,
        notes: [ReferenceTextBlock] = [],
        reviews: [ReferenceReview] = [],
        relations: [ReferenceRelation] = [],
        tags: ReferenceTagSet = ReferenceTagSet()
    ) {
        self.init(
            title: title,
            location: ReferenceURL(url),
            source: source,
            authors: authors,
            date: date,
            container: container,
            doi: doi,
            kind: kind,
            channel: channel,
            abstract: abstract,
            notes: notes,
            reviews: reviews,
            relations: relations,
            tags: tags
        )
    }

    public init(
        title: String,
        url: String,
        authorLine: String? = nil,
        dateISO8601: String? = nil,
        doi: String? = nil,
        kind: ReferenceKind = .other,
        channel: ReferenceChannel = .unknown,
        notes: [ReferenceTextBlock] = [],
        reviews: [ReferenceReview] = [],
        relations: [ReferenceRelation] = [],
        tags: ReferenceTagSet = ReferenceTagSet()
    ) {
        self.init(
            title: title,
            location: ReferenceURL(url),
            authors: authorLine.map {
                ReferenceAuthors(original: $0)
            },
            dates: ReferenceDates(
                published: try? dateISO8601.map(PartialDate.iso8601)
            ),
            doi: doi,
            kind: kind,
            channel: channel,
            notes: notes,
            reviews: reviews,
            relations: relations,
            tags: tags
        )
    }

    public var url: String {
        location.rawValue
    }

    public var sourceKey: String? {
        source?.key
    }

    public var sourceLabel: String? {
        source?.label
    }

    public var sourceHost: String? {
        source?.host ?? location.normalizedHost
    }

    public var authorLine: String? {
        authors?.rendered(.original)
    }

    public var authorKeys: [String] {
        authors?.authorKeys ?? []
    }

    public var authorFamilyKeys: [String] {
        authors?.familyKeys ?? []
    }

    public var date: PartialDate? {
        dates.primary
    }

    public var dateISO8601: String? {
        dates.publishedISO8601
    }

    public var updatedISO8601: String? {
        dates.updatedISO8601
    }

    public var accessedISO8601: String? {
        dates.accessedISO8601
    }

    public var recencySortKey: Int? {
        dates.recencySortKey
    }

    public var abstractText: String? {
        abstract?.text
    }

    public func formatted(
        _ style: ReferenceFormatStyle = .compact
    ) -> String {
        ReferenceFormatter.format(
            self,
            style: style
        )
    }

    public var searchTerms: [String] {
        var terms = [
            title,
            url,
            doi,
            sourceKey,
            sourceLabel,
            sourceHost,
            kind.rawValue,
            channel.rawValue,
            dateISO8601,
            updatedISO8601,
            accessedISO8601,
            abstract?.text,
        ].compactMap { $0 }

        terms.append(contentsOf: authors?.searchTerms ?? [])
        terms.append(contentsOf: dates.searchTerms)
        terms.append(contentsOf: container?.searchTerms ?? [])
        terms.append(contentsOf: notes.flatMap(\.searchTerms))
        terms.append(contentsOf: reviews.flatMap(\.searchTerms))
        terms.append(contentsOf: relations.flatMap(\.searchTerms))
        terms.append(contentsOf: tags.searchTerms)

        return Array(Set(terms))
            .sorted()
    }
}
