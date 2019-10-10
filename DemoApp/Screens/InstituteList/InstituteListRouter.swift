
import UIKit

final class InstituteListRouter: InstituteListDataPassing { 
  
    weak var viewController: InstituteListViewController?
    var dataStore: InstituteListDataStore?

}

// MARK: - InstituteListRouterType 

extension InstituteListRouter: InstituteListRouterType {

    func routeToInstitute(institute: HealthInstitute) {

        let instituteVC = InstituteViewController(nibName: nil, bundle: nil)
        InstituteConfigurator.configure(viewController: instituteVC, institute: institute)

        viewController?.navigationController?.pushViewController(instituteVC, animated: true)

    }

}
