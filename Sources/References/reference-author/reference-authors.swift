public struct ReferenceAuthors: Sendable, Codable, Hashable {
    public let values: [ReferenceAuthor]
    public let original: String?

    public init(
        _ values: [ReferenceAuthor],
        original: String? = nil
    ) {
        self.values = values
        self.original = original
    }

    public init(
        original: String
    ) {
        self.values = []
        self.original = original
    }

    public var isEmpty: Bool {
        values.isEmpty && (original?.isEmpty ?? true)
    }

    public var authorKeys: [String] {
        values.compactMap(\.searchKey)
    }

    public var familyKeys: [String] {
        values.compactMap(\.familyKey)
    }

    public var searchTerms: [String] {
        var terms = values.flatMap(\.searchTerms)

        if let original, !original.isEmpty {
            terms.append(original)
        }

        return Array(Set(terms))
            .sorted()
    }

    public func rendered(
        _ format: ReferenceAuthorFormat = .original
    ) -> String? {
        if format.names == .original_or_full, let original, !original.isEmpty {
            return original
        }

        let renderedValues = values.compactMap {
            $0.rendered(style: format.names)
        }

        if renderedValues.isEmpty {
            return original
        }

        switch format.list {
        case .all:
            return join(renderedValues, format: format)

        case .first_et_al:
            guard let first = renderedValues.first else {
                return original
            }

            if renderedValues.count == 1 {
                return first
            }

            return "\(first) \(format.etAl)"

        case .limit_et_al(let count):
            let limit = max(count, 1)

            if renderedValues.count <= limit {
                return join(renderedValues, format: format)
            }

            return "\(join(Array(renderedValues.prefix(limit)), format: format)) \(format.etAl)"
        }
    }

    private func join(
        _ values: [String],
        format: ReferenceAuthorFormat
    ) -> String {
        guard values.count > 1 else {
            return values.first ?? ""
        }

        guard values.count > 2 else {
            return values.joined(separator: format.finalSeparator)
        }

        return values
            .dropLast()
            .joined(separator: format.separator)
            + format.finalSeparator
            + (values.last ?? "")
    }
}
