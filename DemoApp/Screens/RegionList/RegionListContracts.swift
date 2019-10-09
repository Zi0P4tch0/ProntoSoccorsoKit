
// MARK: - Router

protocol RegionListRouterType {

}

// MARK: - Data Store & Data Passing

protocol RegionListDataStore {

}

protocol RegionListDataPassing {
    var dataStore: RegionListDataStore? { get }
}

// MARK: - Interactor

protocol RegionListInteractorInput {
    func viewDidLoad()
}

// MARK: - Presenter

protocol RegionListPresenterInput {
    func updateData(response: RegionList.Data.Response)
}

// MARK: - View

protocol RegionListViewInput: class {
    func presentData(viewModel: RegionList.Data.ViewModel)
}

// MARK: - Typealiases

typealias RegionListViewOutput = RegionListInteractorInput
typealias RegionListInteractorOutput = RegionListPresenterInput
typealias RegionListPresenterOutput = RegionListViewInput
