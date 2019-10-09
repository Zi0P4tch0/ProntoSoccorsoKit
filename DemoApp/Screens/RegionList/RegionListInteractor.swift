
import Foundation
import ProntoSoccorsoKit

final class RegionListInteractor: RegionListDataStore {

    var output: RegionListInteractorOutput?

    private let allRegions: [Region] = [
        .lazio,
        .friuliVeneziaGiulia,
        .lombardia(.valtellinaEAltoLario),
        .puglia(.taranto),
        .trentinoAltoAdige(.trento)
    ]

}

// MARK: RegionListInteractorInput

extension RegionListInteractor: RegionListInteractorInput  {

    func viewDidLoad() {
        output?.updateData(response:
            RegionList.Data.Response(regions: allRegions)
        )
    }

}
