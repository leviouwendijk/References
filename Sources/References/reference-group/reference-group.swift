public struct ReferenceGroup: Sendable, ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = any ReferenceProviding

    public let references: [any ReferenceProviding]

    public init(
        _ references: [any ReferenceProviding]
    ) {
        self.references = Self.deduped(references)
    }

    public init(
        _ reference: any ReferenceProviding
    ) {
        self.init([reference])
    }

    public init(
        arrayLiteral elements: any ReferenceProviding...
    ) {
        self.init(elements)
    }

    public var isEmpty: Bool {
        references.isEmpty
    }

    public func adding(
        _ reference: any ReferenceProviding
    ) -> ReferenceGroup {
        ReferenceGroup(
            references + [reference]
        )
    }

    public func adding(
        _ group: ReferenceGroup
    ) -> ReferenceGroup {
        ReferenceGroup(
            references + group.references
        )
    }

    private static func deduped(
        _ references: [any ReferenceProviding]
    ) -> [any ReferenceProviding] {
        var seen: Set<String> = []

        return references.filter { reference in
            seen.insert(reference.public_name_or_id).inserted
        }
    }
}

public func + (
    lhs: ReferenceGroup,
    rhs: ReferenceGroup
) -> ReferenceGroup {
    lhs.adding(rhs)
}

public func + (
    lhs: ReferenceGroup,
    rhs: any ReferenceProviding
) -> ReferenceGroup {
    lhs.adding(rhs)
}

public func + (
    lhs: any ReferenceProviding,
    rhs: ReferenceGroup
) -> ReferenceGroup {
    ReferenceGroup(lhs).adding(rhs)
}

public func + (
    lhs: any ReferenceProviding,
    rhs: any ReferenceProviding
) -> ReferenceGroup {
    ReferenceGroup([
        lhs,
        rhs,
    ])
}
