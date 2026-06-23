public enum ReferenceChannel: String, Sendable, Codable, Hashable, CaseIterable {
    case peer_reviewed
    case scholarly
    case preprint
    case textbook
    case professional
    case institutional
    case popular
    case internal_note
    case unknown
}
