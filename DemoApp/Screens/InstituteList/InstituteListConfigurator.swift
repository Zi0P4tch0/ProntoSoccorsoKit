
import ProntoSoccorsoKit

enum InstituteListConfigurator {

    static func configure(viewController: InstituteListViewController, withRegion region: Region) {
        let interactor = InstituteListInteractor()
        let presenter = InstituteListPresenter()
        let router = InstituteListRouter()
        viewController.output = interactor
        viewController.router = router
        interactor.output = presenter
        presenter.output = viewController // weak ref
        router.viewController = viewController // weak ref
        router.dataStore = interactor
        router.dataStore?.region = region
    }

}
