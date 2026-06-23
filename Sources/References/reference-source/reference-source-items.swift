public extension ReferenceSource {
    static let arxiv = ReferenceSource(
        key: "arxiv",
        label: "arXiv",
        host: "arxiv.org"
    )

    static let doi = ReferenceSource(
        key: "doi",
        label: "DOI",
        host: "doi.org"
    )

    static let frontiers = ReferenceSource(
        key: "frontiers",
        label: "Frontiers",
        host: "frontiersin.org"
    )

    static let plos = ReferenceSource(
        key: "plos",
        label: "PLOS",
        host: "plos.org"
    )

    static let pubmed = ReferenceSource(
        key: "pubmed",
        label: "PubMed",
        host: "pubmed.ncbi.nlm.nih.gov"
    )

    static let sciencedirect = ReferenceSource(
        key: "sciencedirect",
        label: "ScienceDirect",
        host: "sciencedirect.com"
    )

    static let springer = ReferenceSource(
        key: "springer",
        label: "Springer",
        host: "springer.com"
    )

    static let wiley = ReferenceSource(
        key: "wiley",
        label: "Wiley",
        host: "wiley.com"
    )
}
