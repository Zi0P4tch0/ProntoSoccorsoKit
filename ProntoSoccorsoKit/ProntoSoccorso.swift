
/// ProntoSoccorsoKit's namespace.
public enum ProntoSoccorso {

    public static func region(_ region: Region) -> Request {
        RequestImplementation(for: region)
    }

    public static func regions(_ regions: [Region]) -> Request? {
        regions.map { RequestImplementation(for: $0) }.combine()
    }

}
