public enum ReferenceKind: String, Sendable, Codable, Hashable, CaseIterable {
    case article
    case book
    case book_chapter
    case preprint
    case thesis
    case dissertation
    case guideline
    case position_statement
    case report
    case legislation
    case regulation
    case standard
    case technical_specification
    case product_catalogue
    case dataset
    case webpage
    case video
    case other
}
