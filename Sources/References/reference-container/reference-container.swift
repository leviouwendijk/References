public struct ReferenceContainer: Sendable, Codable, Hashable {
    public let kind: ReferenceContainerKind
    public let title: String?
    public let publisher: String?
    public let volume: String?
    public let issue: String?
    public let pages: String?
    public let edition: String?
    public let isbn: String?
    public let issn: String?

    public init(
        kind: ReferenceContainerKind = .other,
        title: String? = nil,
        publisher: String? = nil,
        volume: String? = nil,
        issue: String? = nil,
        pages: String? = nil,
        edition: String? = nil,
        isbn: String? = nil,
        issn: String? = nil
    ) {
        self.kind = kind
        self.title = title
        self.publisher = publisher
        self.volume = volume
        self.issue = issue
        self.pages = pages
        self.edition = edition
        self.isbn = isbn
        self.issn = issn
    }

    public static func journal(
        title: String,
        volume: String? = nil,
        issue: String? = nil,
        pages: String? = nil,
        publisher: String? = nil,
        issn: String? = nil
    ) -> ReferenceContainer {
        ReferenceContainer(
            kind: .journal,
            title: title,
            publisher: publisher,
            volume: volume,
            issue: issue,
            pages: pages,
            issn: issn
        )
    }

    public static func website(
        title: String,
        publisher: String? = nil
    ) -> ReferenceContainer {
        ReferenceContainer(
            kind: .website,
            title: title,
            publisher: publisher
        )
    }

    public static func book(
        title: String,
        publisher: String? = nil,
        edition: String? = nil,
        isbn: String? = nil
    ) -> ReferenceContainer {
        ReferenceContainer(
            kind: .book,
            title: title,
            publisher: publisher,
            edition: edition,
            isbn: isbn
        )
    }

    public static func proceedings(
        title: String,
        publisher: String? = nil,
        pages: String? = nil
    ) -> ReferenceContainer {
        ReferenceContainer(
            kind: .proceedings,
            title: title,
            publisher: publisher,
            pages: pages
        )
    }

    public var searchTerms: [String] {
        [
            kind.rawValue,
            title,
            publisher,
            volume,
            issue,
            pages,
            edition,
            isbn,
            issn,
        ]
        .compactMap { $0 }
        .filter { !$0.isEmpty }
    }
}
