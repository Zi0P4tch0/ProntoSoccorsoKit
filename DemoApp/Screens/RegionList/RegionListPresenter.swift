
import Foundation
import ProntoSoccorsoKit

final class RegionListPresenter {

    weak var output: RegionListPresenterOutput?

}

// MARK: RegionListPresenterInput

extension RegionListPresenter: RegionListPresenterInput {

    func updateData(response: RegionList.Data.Response) {
        output?.presentData(viewModel:
            RegionList.Data.ViewModel(regions: response.regions.map { $0.displayName })
        )
    }

}

extension Region {

    var displayName: String {
        switch self {
        case .lazio: return "Lazio"
        case .friuliVeneziaGiulia: return "Friuli-Venezia Giulia"
        case .lombardia(.valtellinaEAltoLario): return "Lombardia (Valtellina e Alto Lario)"
        case .puglia(.taranto): return "Puglia (Taranto)"
        case .trentinoAltoAdige(.trento): return "Trentino-Alto Adige (Trento)"
        }
    }

}
