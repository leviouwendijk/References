public struct ReferenceRelation: Sendable, Codable, Hashable {
    public let kind: ReferenceRelationKind
    public let targetID: String?
    public let title: String?
    public let location: ReferenceURL?

    public init(
        kind: ReferenceRelationKind,
        targetID: String? = nil,
        title: String? = nil,
        location: ReferenceURL? = nil
    ) {
        self.kind = kind
        self.targetID = targetID
        self.title = title
        self.location = location
    }

    public static func related(
        targetID: String
    ) -> ReferenceRelation {
        ReferenceRelation(
            kind: .related,
            targetID: targetID
        )
    }

    public static func dataset(
        title: String? = nil,
        location: ReferenceURL
    ) -> ReferenceRelation {
        ReferenceRelation(
            kind: .dataset,
            title: title,
            location: location
        )
    }

    public static func supplement(
        title: String? = nil,
        location: ReferenceURL
    ) -> ReferenceRelation {
        ReferenceRelation(
            kind: .supplement,
            title: title,
            location: location
        )
    }

    public static func sameWork(
        title: String? = nil,
        location: ReferenceURL
    ) -> ReferenceRelation {
        ReferenceRelation(
            kind: .same_work,
            title: title,
            location: location
        )
    }

    public var searchTerms: [String] {
        [
            kind.rawValue,
            targetID,
            title,
            location?.rawValue,
        ]
        .compactMap { $0 }
        .filter { !$0.isEmpty }
    }
}
