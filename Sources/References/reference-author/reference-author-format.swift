public struct ReferenceAuthorFormat: Sendable, Codable, Hashable {
    public let names: ReferenceAuthorNameStyle
    public let list: ReferenceAuthorListStyle
    public let separator: String
    public let finalSeparator: String
    public let etAl: String

    public init(
        names: ReferenceAuthorNameStyle = .original_or_full,
        list: ReferenceAuthorListStyle = .all,
        separator: String = ", ",
        finalSeparator: String = " & ",
        etAl: String = "et al."
    ) {
        self.names = names
        self.list = list
        self.separator = separator
        self.finalSeparator = finalSeparator
        self.etAl = etAl
    }

    public static let original = ReferenceAuthorFormat(
        names: .original_or_full
    )

    public static let full = ReferenceAuthorFormat(
        names: .full
    )

    public static let initials_family = ReferenceAuthorFormat(
        names: .initials_family
    )

    public static let first_et_al = ReferenceAuthorFormat(
        names: .initials_family,
        list: .first_et_al
    )

    public static func limited(
        _ count: Int,
        names: ReferenceAuthorNameStyle = .initials_family
    ) -> ReferenceAuthorFormat {
        ReferenceAuthorFormat(
            names: names,
            list: .limit_et_al(count)
        )
    }
}
