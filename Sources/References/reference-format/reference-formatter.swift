public enum ReferenceFormatter {
    public static func format(
        _ data: ReferenceData,
        style: ReferenceFormatStyle = .compact
    ) -> String {
        switch style {
        case .compact:
            return compact(data)

        case .apa_like:
            return apaLike(data)

        case .chicago_like:
            return chicagoLike(data)

        case .mla_like:
            return mlaLike(data)

        case .vancouver_like:
            return vancouverLike(data)
        }
    }

    private static func compact(
        _ data: ReferenceData
    ) -> String {
        joinSentenceParts(
            [
                data.authorLine,
                data.dateISO8601.map { "(\($0))" },
                data.title,
                data.container?.title,
                data.doi.map { "doi:\($0)" },
                data.url,
            ]
        )
    }

    private static func apaLike(
        _ data: ReferenceData
    ) -> String {
        joinSentenceParts(
            [
                data.authors?.rendered(.first_et_al),
                data.dateISO8601.map { "(\($0))" },
                data.title,
                containerSegment(data),
                doiOrURL(data),
            ]
        )
    }

    private static func chicagoLike(
        _ data: ReferenceData
    ) -> String {
        joinSentenceParts(
            [
                data.authorLine,
                quote(data.title),
                containerSegment(data),
                data.dateISO8601,
                doiOrURL(data),
            ]
        )
    }

    private static func mlaLike(
        _ data: ReferenceData
    ) -> String {
        joinSentenceParts(
            [
                data.authorLine,
                quote(data.title),
                data.container?.title,
                data.container?.publisher,
                data.dateISO8601,
                doiOrURL(data),
            ]
        )
    }

    private static func vancouverLike(
        _ data: ReferenceData
    ) -> String {
        joinSentenceParts(
            [
                data.authors?.rendered(.limited(6)),
                data.title,
                containerSegment(data),
                data.dateISO8601,
                doiOrURL(data),
            ]
        )
    }

    private static func containerSegment(
        _ data: ReferenceData
    ) -> String? {
        guard let container = data.container else {
            return nil
        }

        var parts: [String] = []

        if let title = container.title {
            parts.append(title)
        }

        if let volume = container.volume {
            var volumeIssue = volume

            if let issue = container.issue {
                volumeIssue += "(\(issue))"
            }

            parts.append(volumeIssue)
        }

        if let pages = container.pages {
            parts.append(pages)
        }

        if let publisher = container.publisher {
            parts.append(publisher)
        }

        return parts.isEmpty
            ? nil
            : parts.joined(separator: ", ")
    }

    private static func doiOrURL(
        _ data: ReferenceData
    ) -> String? {
        if let doi = data.doi {
            return "https://doi.org/\(doi)"
        }

        return data.url
    }

    private static func quote(
        _ value: String
    ) -> String {
        "“\(value)”"
    }

    private static func joinSentenceParts(
        _ parts: [String?]
    ) -> String {
        parts
            .compactMap { $0 }
            .map {
                $0.trimmingCharacters(in: .whitespacesAndNewlines)
            }
            .filter { !$0.isEmpty }
            .joined(separator: ". ")
    }
}
