import Foundation

public extension ReferenceSource {
    var origin: String? {
        guard let host else {
            return nil
        }

        return "https://\(host)"
    }

    func url(
        _ path: String = ""
    ) -> ReferenceURL {
        guard let origin else {
            return ReferenceURL(path)
        }

        let trimmedPath = path.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmedPath.isEmpty else {
            return ReferenceURL(origin)
        }

        if trimmedPath.hasPrefix("http://") || trimmedPath.hasPrefix("https://") {
            return ReferenceURL(trimmedPath)
        }

        let cleanOrigin = origin.hasSuffix("/")
            ? String(origin.dropLast())
            : origin

        let cleanPath = trimmedPath.hasPrefix("/")
            ? String(trimmedPath.dropFirst())
            : trimmedPath

        return ReferenceURL("\(cleanOrigin)/\(cleanPath)")
    }

    func url(
        _ components: String...
    ) -> ReferenceURL {
        url(
            components
                .map { component in
                    component.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
                }
                .filter { !$0.isEmpty }
                .joined(separator: "/")
        )
    }
}
