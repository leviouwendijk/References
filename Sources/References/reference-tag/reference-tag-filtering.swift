public extension Sequence where Element: ReferenceProviding {
    func tagged(
        _ tag: ReferenceTag
    ) -> [Element] {
        filter {
            $0.tags.contains(tag)
        }
    }

    func tagged(
        id: String
    ) -> [Element] {
        filter {
            $0.tags.contains(id: id)
        }
    }

    func tagged(
        namespace: String,
        key: String
    ) -> [Element] {
        filter {
            $0.tags.contains(
                namespace: namespace,
                key: key
            )
        }
    }

    func taggedAny(
        _ tags: [ReferenceTag]
    ) -> [Element] {
        filter { reference in
            tags.contains { tag in
                reference.tags.contains(tag)
            }
        }
    }

    func taggedAll(
        _ tags: [ReferenceTag]
    ) -> [Element] {
        filter { reference in
            tags.allSatisfy { tag in
                reference.tags.contains(tag)
            }
        }
    }

    func dedupedByPublicNameOrID() -> [Element] {
        var seen: Set<String> = []

        return filter { reference in
            seen.insert(reference.public_name_or_id).inserted
        }
    }
}
