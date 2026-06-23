public struct ReferenceTextBlock: Sendable, Codable, Hashable {
    public let text: String
    public let kind: ReferenceTextKind
    public let language: String?

    public init(
        _ text: String,
        kind: ReferenceTextKind,
        language: String? = nil
    ) {
        self.text = text
        self.kind = kind
        self.language = language
    }

    public static func abstract(
        _ text: String,
        language: String? = nil
    ) -> ReferenceTextBlock {
        ReferenceTextBlock(
            text,
            kind: .abstract,
            language: language
        )
    }

    public static func summary(
        _ text: String,
        language: String? = nil
    ) -> ReferenceTextBlock {
        ReferenceTextBlock(
            text,
            kind: .summary,
            language: language
        )
    }

    public static func note(
        _ text: String,
        language: String? = nil
    ) -> ReferenceTextBlock {
        ReferenceTextBlock(
            text,
            kind: .note,
            language: language
        )
    }

    public static func excerpt(
        _ text: String,
        language: String? = nil
    ) -> ReferenceTextBlock {
        ReferenceTextBlock(
            text,
            kind: .excerpt,
            language: language
        )
    }

    public var searchTerms: [String] {
        [
            kind.rawValue,
            text,
            language,
        ]
        .compactMap { $0 }
        .filter { !$0.isEmpty }
    }
}
