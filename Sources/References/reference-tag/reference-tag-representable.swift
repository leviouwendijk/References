public protocol ReferenceTagRepresentable: RawRepresentable where RawValue == String {
    static var namespace: String { get }

    var label: String { get }
}

public extension ReferenceTagRepresentable {
    var label: String {
        rawValue.tagLabel
    }

    var tag: ReferenceTag {
        ReferenceTag(
            namespace: Self.namespace,
            key: rawValue,
            label: label
        )
    }
}

public extension Sequence where Element: ReferenceTagRepresentable {
    var tags: ReferenceTagSet {
        ReferenceTagSet(
            map(\.tag)
        )
    }
}

public extension String {
    var tagLabel: String {
        split(separator: "_")
            .map { part -> String in
                guard let first = part.first else {
                    return ""
                }

                return String(first).uppercased() + String(part.dropFirst())
            }
            .joined(separator: " ")
    }
}
