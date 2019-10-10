
// MARK: - Router

protocol InstituteListRouterType {
    func routeToInstitute(institute: HealthInstitute)
}

// MARK: - Data Store & Data Passing

protocol InstituteListDataStore {
    var region: Region! { get set }
}

protocol InstituteListDataPassing {
    var dataStore: InstituteListDataStore? { get }
}

// MARK: - Interactor

protocol InstituteListInteractorInput {
    func viewDidLoad()
    func rowSelected(request: InstituteList.RowSelected.Request)
    func refreshTapped()
}

// MARK: - Presenter

protocol InstituteListPresenterInput {
    func updateTitle(response: InstituteList.Title.Response)
    func updateData(response: InstituteList.Data.Response)
    func updateLoading(response: InstituteList.Loading.Response)
    func updateError(response: InstituteList.Error.Response)
    func routeToInstitute(institute: HealthInstitute)
    func updateRefreshButtonStatus(response: InstituteList.RefreshButtonStatus.Response)
}

// MARK: - View

protocol InstituteListViewInput: class {
    func presentTitle(viewModel: InstituteList.Title.ViewModel)
    func presentData(viewModel: InstituteList.Data.ViewModel)
    func presentLoading(viewModel: InstituteList.Loading.ViewModel)
    func presentError(viewModel: InstituteList.Error.ViewModel)
    func routeToInstitute(institute: HealthInstitute)
    func presentRefreshButtonStatus(viewModel: InstituteList.RefreshButtonStatus.ViewModel)
}

// MARK: - Typealiases

typealias InstituteListViewOutput = InstituteListInteractorInput
typealias InstituteListInteractorOutput = InstituteListPresenterInput
typealias InstituteListPresenterOutput = InstituteListViewInput
