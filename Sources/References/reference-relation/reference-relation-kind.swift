public enum ReferenceRelationKind: String, Sendable, Codable, Hashable, CaseIterable {
    case cites
    case cited_by
    case reviews
    case reviewed_by
    case erratum
    case dataset
    case supplement
    case translation
    case same_work
    case related
}
