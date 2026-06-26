public enum ReferenceLocatorKind: String, Sendable, Codable, Hashable, CaseIterable {
    case page
    case pages
    case chapter
    case section
    case paragraph
    case line
    case lines
    case table
    case figure
    case timestamp
    case custom

    public var label: String {
        switch self {
        case .page:
            return "p."
        case .pages:
            return "pp."
        case .chapter:
            return "chapter"
        case .section:
            return "section"
        case .paragraph:
            return "paragraph"
        case .line:
            return "line"
        case .lines:
            return "lines"
        case .table:
            return "table"
        case .figure:
            return "figure"
        case .timestamp:
            return "timestamp"
        case .custom:
            return ""
        }
    }
}
