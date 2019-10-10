
import ProntoSoccorsoKit

// MARK: - Router

protocol RegionListRouterType {
    func routeToInstituteList(region: Region)
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
    func cellTapped(atIndex: Int)
}

// MARK: - Presenter

protocol RegionListPresenterInput {
    func updateData(response: RegionList.Data.Response)
    func routeToInstituteList(region: Region)
}

// MARK: - View

protocol RegionListViewInput: class {
    func presentData(viewModel: RegionList.Data.ViewModel)
    func routeToInstituteList(region: Region)
}

// MARK: - Typealiases

typealias RegionListViewOutput = RegionListInteractorInput
typealias RegionListInteractorOutput = RegionListPresenterInput
typealias RegionListPresenterOutput = RegionListViewInput
