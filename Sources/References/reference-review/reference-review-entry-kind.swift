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

    public var dutch: String {
        switch self {
        case .overview:
            return "Overzicht"
        case .method:
            return "Methode"
        case .finding:
            return "Bevinding"
        case .limitation:
            return "Beperking"
        case .takeaway:
            return "Kernpunt"
        case .interpretation:
            return "Interpretatie"
        case .caution:
            return "Voorbehoud"
        case .relevance:
            return "Relevantie"
        }
    }
}
