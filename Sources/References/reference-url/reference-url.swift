import Foundation

public struct ReferenceURL: Sendable, Codable, Hashable {
    public let rawValue: String

    public init(
        _ rawValue: String
    ) {
        self.rawValue = rawValue
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }

    public static func web(
        _ rawValue: String
    ) -> ReferenceURL {
        ReferenceURL(rawValue)
    }

    public var url: URL? {
        URL(string: rawValue)
    }

    public var scheme: String? {
        url?.scheme?.lowercased()
    }

    public var host: String? {
        url?.host()?.lowercased()
    }

    public var normalizedHost: String? {
        guard var host else {
            return nil
        }

        for prefix in ["www.", "m."] {
            if host.hasPrefix(prefix) {
                host.removeFirst(prefix.count)
            }
        }

        return host
    }

    public var sourceKey: String? {
        normalizedHost?
            .split(separator: ".")
            .first
            .map(String.init)?
            .normalizedReferenceKey
    }

    public var sourceLabel: String? {
        guard let key = sourceKey else {
            return nil
        }

        return key
            .split(separator: "-")
            .map { part in
                part.prefix(1).uppercased() + part.dropFirst()
            }
            .joined(separator: " ")
    }

    public var isHTTP: Bool {
        scheme == "http" || scheme == "https"
    }
}
