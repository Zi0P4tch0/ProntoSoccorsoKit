
import ProntoSoccorsoKit

// MARK: - Router

protocol InstituteListRouterType {

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
}

// MARK: - Presenter

protocol InstituteListPresenterInput {
    func updateTitle(response: InstituteList.Title.Response)
    func updateData(response: InstituteList.Data.Response)
    func updateLoading(response: InstituteList.Loading.Response)
}

// MARK: - View

protocol InstituteListViewInput: class {
    func presentTitle(viewModel: InstituteList.Title.ViewModel)
    func presentData(viewModel: InstituteList.Data.ViewModel)
    func presentLoading(viewModel: InstituteList.Loading.ViewModel)
}

// MARK: - Typealiases

typealias InstituteListViewOutput = InstituteListInteractorInput
typealias InstituteListInteractorOutput = InstituteListPresenterInput
typealias InstituteListPresenterOutput = InstituteListViewInput
