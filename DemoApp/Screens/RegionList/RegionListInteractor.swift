
import Foundation

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

    func selectedRow(request: RegionList.RowSelected.Request) {
        let region = allRegions[request.index]
        output?.routeToInstituteList(region: region)
    }

}
