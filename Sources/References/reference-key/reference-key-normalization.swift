import Foundation

public extension String {
    var normalizedReferenceKey: String {
        let folded = folding(
            options: [.diacriticInsensitive, .caseInsensitive],
            locale: Locale(identifier: "en_US_POSIX")
        )

        let scalars = folded.unicodeScalars.map { scalar -> Character in
            if CharacterSet.alphanumerics.contains(scalar) {
                return Character(scalar)
            }

            return "-"
        }

        let collapsed = String(scalars)
            .split(separator: "-", omittingEmptySubsequences: true)
            .joined(separator: "-")

        return collapsed.lowercased()
    }
}
