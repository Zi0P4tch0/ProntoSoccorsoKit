
enum RegionListConfigurator {

    static func configure(viewController: RegionListViewController) {
        let interactor = RegionListInteractor()
        let presenter = RegionListPresenter()
        let router = RegionListRouter()
        viewController.output = interactor
        viewController.router = router
        interactor.output = presenter
        presenter.output = viewController // weak ref
        router.viewController = viewController // weak ref
        router.dataStore = interactor
    }

}
