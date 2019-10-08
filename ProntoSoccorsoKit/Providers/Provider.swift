
import Foundation

protocol Provider {
    /// Returns `true` if needs scraping, `false` otherwise.
    var isScraping: Bool { get }
    /// String representation of the URL where the data resides.
    var urlString: String { get }
    /// `Data` to institutes mapper.
    var mapper: (Data) throws -> [HealthInstitute] { get }
}

// MARK: - Region + Provider
extension Region {
    var provider: Provider {
        switch self {
        case .lazio: return RegioneLazioProvider()
        case .puglia: return RegionePugliaTarantoProvider()
        case .friuliVeneziaGiulia: return RegioneFriuliVeneziaGiuliaProvider()
        case .lombardia: return RegioneLombardiaValtellinaEAltoLarioProvider()
        case .trentinoAltoAdige: return RegioneTrentinoAltoAdigeTrentoProvider()
        }
    }
}
