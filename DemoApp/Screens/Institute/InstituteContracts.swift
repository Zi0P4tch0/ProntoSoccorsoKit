
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

}

// MARK: - Presenter

protocol InstitutePresenterInput {

}

// MARK: - View

protocol InstituteViewInput: class {

}

// MARK: - Typealiases

typealias InstituteViewOutput = InstituteInteractorInput
typealias InstituteInteractorOutput = InstitutePresenterInput
typealias InstitutePresenterOutput = InstituteViewInput
