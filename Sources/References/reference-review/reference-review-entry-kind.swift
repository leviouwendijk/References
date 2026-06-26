public enum ReferenceReviewEntryKind: String, Sendable, Codable, Hashable, CaseIterable {
    case overview
    case method
    case finding
    case limitation
    case takeaway
    case interpretation
    case caution
    case relevance

    public var label: String {
        switch self {
        case .overview:
            return "Overview"
        case .method:
            return "Method"
        case .finding:
            return "Finding"
        case .limitation:
            return "Limitation"
        case .takeaway:
            return "Takeaway"
        case .interpretation:
            return "Interpretation"
        case .caution:
            return "Caution"
        case .relevance:
            return "Relevance"
        }
    }
}
