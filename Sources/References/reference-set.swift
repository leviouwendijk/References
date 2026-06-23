public struct ReferenceSet<Source: ReferenceProviding>: Sendable {
    public let id: String
    public let title: String
    public let summary: String?
    public let sources: [Source]

    public init(
        id: String,
        title: String,
        summary: String? = nil,
        sources: [Source]
    ) {
        self.id = id
        self.title = title
        self.summary = summary
        self.sources = sources
    }
}
