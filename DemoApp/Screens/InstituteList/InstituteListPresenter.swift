
import Foundation

final class InstituteListPresenter {

    weak var output: InstituteListPresenterOutput?

}

// MARK: InstituteListPresenterInput

extension InstituteListPresenter: InstituteListPresenterInput {

    func updateTitle(response: InstituteList.Title.Response) {
        output?.presentTitle(viewModel:
            InstituteList.Title.ViewModel(title: response.region.displayName)
        )
    }

    func updateData(response: InstituteList.Data.Response) {
        output?.presentData(viewModel:
            InstituteList.Data.ViewModel(institutes: response.institutes.map { $0.name })
        )
    }

    func updateLoading(response: InstituteList.Loading.Response) {
        output?.presentLoading(viewModel:
            InstituteList.Loading.ViewModel(loading: response.loading)
        )
    }

    func updateError(response: InstituteList.Error.Response) {
        let viewModel = InstituteList.Error.ViewModel(title: "Error", message: response.error.localizedDescription)
        output?.presentError(viewModel: viewModel)
    }

    func routeToInstitute(institute: HealthInstitute) {
        output?.routeToInstitute(institute: institute)
    }

    func updateRefreshButtonStatus(response: InstituteList.RefreshButtonStatus.Response) {
        output?.presentRefreshButtonStatus(viewModel:
            InstituteList.RefreshButtonStatus.ViewModel(enabled: response.enabled)
        )
    }
}
