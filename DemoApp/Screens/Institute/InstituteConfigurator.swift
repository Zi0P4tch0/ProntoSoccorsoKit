
enum InstituteConfigurator {

    static func configure(viewController: InstituteViewController, institute: HealthInstitute) {
        let interactor = InstituteInteractor()
        let presenter = InstitutePresenter()
        let router = InstituteRouter()
        viewController.output = interactor
        viewController.router = router
        interactor.output = presenter
        presenter.output = viewController // weak ref
        router.viewController = viewController // weak ref
        router.dataStore = interactor
        router.dataStore?.institute = institute
    }

}
