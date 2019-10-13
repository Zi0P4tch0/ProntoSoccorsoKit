
/// ProntoSoccorsoKit's namespace.
public enum ProntoSoccorso {

    /// Creates a request for pronto soccorso's data for a single region.
    ///
    /// - Parameter region: Region to query.
    ///
    /// - Returns: A request object for the specified region.
    ///
    public static func region(_ region: Region) -> Request {
        return RequestImplementation(for: region)
    }

    /// Creates a request for pronto soccorso's data for multiple regions.
    ///
    /// - Parameter regions: Regions to query.
    ///
    /// - Returns: A request object for the specified regions if `regions` is not empty, `nil` otherwise.
    ///
    public static func regions(_ regions: [Region]) -> Request? {
        guard !regions.isEmpty else { return nil }
        let requests = regions.map { RequestImplementation(for: $0) }
        guard requests.count > 1 else { return requests.first }
        return requests.reduce(requests.first!, { lhs, rhs in
            return CombinedRequest(one: lhs, two: rhs)
        })
    }

}
