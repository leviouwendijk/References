public protocol ReferenceTagRepresentable: RawRepresentable where RawValue == String {
    static var referenceTagNamespace: String { get }

    var referenceTagLabel: String { get }
}

public extension ReferenceTagRepresentable {
    var referenceTagLabel: String {
        rawValue.referenceTagDefaultLabel
    }

    var referenceTag: ReferenceTag {
        ReferenceTag(
            namespace: Self.referenceTagNamespace,
            key: rawValue,
            label: referenceTagLabel
        )
    }
}

public extension Sequence where Element: ReferenceTagRepresentable {
    var referenceTags: ReferenceTagSet {
        ReferenceTagSet(
            map(\.referenceTag)
        )
    }
}

public extension String {
    var referenceTagDefaultLabel: String {
        split(separator: "_")
            .map { part in
                part.prefix(1).uppercased() + part.dropFirst()
            }
            .joined(separator: " ")
    }
}
