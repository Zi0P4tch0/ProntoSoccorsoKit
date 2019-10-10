
// MARK: - Router

protocol InstituteRouterType {

}

// MARK: - Data Store & Data Passing

protocol InstituteDataStore {
    var institute: HealthInstitute! { get set }
}

protocol InstituteDataPassing {
    var dataStore: InstituteDataStore? { get }
}

// MARK: - Interactor

protocol InstituteInteractorInput {
    func viewDidLoad()
}

// MARK: - Presenter

protocol InstitutePresenterInput {
    func updateData(response: Institute.Data.Response)
}

// MARK: - View

protocol InstituteViewInput: class {
    func presentData(viewModel: Institute.Data.ViewModel)
}

// MARK: - Typealiases

typealias InstituteViewOutput = InstituteInteractorInput
typealias InstituteInteractorOutput = InstitutePresenterInput
typealias InstitutePresenterOutput = InstituteViewInput
