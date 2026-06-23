import Foundation

public struct ReferenceAuthor: Sendable, Codable, Hashable {
    public let given: String?
    public let family: String?
    public let original: String?

    public init(
        given: String? = nil,
        family: String? = nil,
        original: String? = nil
    ) {
        self.given = given
        self.family = family
        self.original = original
    }

    public static func person(
        given: String,
        family: String,
        original: String? = nil
    ) -> ReferenceAuthor {
        ReferenceAuthor(
            given: given,
            family: family,
            original: original
        )
    }

    public static func original(
        _ value: String
    ) -> ReferenceAuthor {
        ReferenceAuthor(
            original: value
        )
    }

    public var fullName: String? {
        switch (given, family) {
        case (.some(let given), .some(let family)):
            return "\(given) \(family)"

        case (.some(let given), .none):
            return given

        case (.none, .some(let family)):
            return family

        case (.none, .none):
            return original
        }
    }

    public var initialsFamilyName: String? {
        guard let family else {
            return fullName
        }

        guard let given else {
            return family
        }

        let initials = given
            .split(whereSeparator: { $0.isWhitespace || $0 == "-" })
            .compactMap { part -> String? in
                guard let first = part.first else {
                    return nil
                }

                return "\(first)."
            }
            .joined(separator: " ")

        guard !initials.isEmpty else {
            return family
        }

        return "\(initials) \(family)"
    }

    public var searchKey: String? {
        if let family, let given {
            return "\(family)-\(given)".normalizedReferenceKey
        }

        return fullName?.normalizedReferenceKey
    }

    public var familyKey: String? {
        family?.normalizedReferenceKey
    }

    public var searchTerms: [String] {
        [
            given,
            family,
            original,
            fullName,
            initialsFamilyName,
            searchKey,
            familyKey,
        ]
        .compactMap { $0 }
        .filter { !$0.isEmpty }
    }

    public func rendered(
        style: ReferenceAuthorNameStyle
    ) -> String? {
        switch style {
        case .full:
            return fullName

        case .initials_family:
            return initialsFamilyName

        case .original:
            return original

        case .original_or_full:
            return original ?? fullName
        }
    }
}
