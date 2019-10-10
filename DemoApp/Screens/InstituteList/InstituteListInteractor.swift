
import Foundation
import ProntoSoccorsoKit

final class InstituteListInteractor: InstituteListDataStore {

    var output: InstituteListInteractorOutput?

    var region: Region!

    private var institutes: [HealthInstitute] = []

}

// MARK: InstituteListInteractorInput

extension InstituteListInteractor: InstituteListInteractorInput  {

    func viewDidLoad() {

        output?.updateTitle(response:
            InstituteList.Title.Response(region: region)
        )

        fetch()

    }

    func rowSelected(request: InstituteList.RowSelected.Request) {
        let institute = institutes[request.index]
        output?.routeToInstitute(institute: institute)
    }

    func refreshTapped() {

        fetch()

    }

}

// MARK: - Fetch

extension InstituteListInteractor {

    private func fetch() {

        output?.updateLoading(response: InstituteList.Loading.Response(loading: true))
        output?.updateRefreshButtonStatus(response: InstituteList.RefreshButtonStatus.Response(enabled: false))

        ProntoSoccorso.region(region).fetch { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(institutes):
                self.institutes = institutes
                self.output?.updateData(response: InstituteList.Data.Response(institutes: institutes))
            case let .failure(error):
                self.output?.updateError(response: InstituteList.Error.Response(error: error))
            }
            self.output?.updateLoading(response: InstituteList.Loading.Response(loading: false))
            self.output?.updateRefreshButtonStatus(response: InstituteList.RefreshButtonStatus.Response(enabled: true))
        }

    }

}
