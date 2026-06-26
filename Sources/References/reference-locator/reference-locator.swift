public struct ReferenceLocator: Sendable, Codable, Hashable, Identifiable {
    public let kind: ReferenceLocatorKind
    public let value: String

    public var id: String {
        stableKey
    }

    public var stableKey: String {
        "\(kind.rawValue)=\(value)"
    }

    public var rendered: String {
        switch kind {
        case .custom:
            return value
        default:
            return "\(kind.label) \(value)"
        }
    }

    public init(
        _ kind: ReferenceLocatorKind,
        _ value: String
    ) {
        self.kind = kind
        self.value = value
    }
}

public extension ReferenceLocator {
    static func page(
        _ value: String
    ) -> ReferenceLocator {
        ReferenceLocator(.page, value)
    }

    static func pages(
        _ value: String
    ) -> ReferenceLocator {
        ReferenceLocator(.pages, value)
    }

    static func chapter(
        _ value: String
    ) -> ReferenceLocator {
        ReferenceLocator(.chapter, value)
    }

    static func section(
        _ value: String
    ) -> ReferenceLocator {
        ReferenceLocator(.section, value)
    }

    static func paragraph(
        _ value: String
    ) -> ReferenceLocator {
        ReferenceLocator(.paragraph, value)
    }

    static func line(
        _ value: String
    ) -> ReferenceLocator {
        ReferenceLocator(.line, value)
    }

    static func lines(
        _ value: String
    ) -> ReferenceLocator {
        ReferenceLocator(.lines, value)
    }

    static func table(
        _ value: String
    ) -> ReferenceLocator {
        ReferenceLocator(.table, value)
    }

    static func figure(
        _ value: String
    ) -> ReferenceLocator {
        ReferenceLocator(.figure, value)
    }

    static func timestamp(
        _ value: String
    ) -> ReferenceLocator {
        ReferenceLocator(.timestamp, value)
    }

    static func custom(
        _ value: String
    ) -> ReferenceLocator {
        ReferenceLocator(.custom, value)
    }
}
