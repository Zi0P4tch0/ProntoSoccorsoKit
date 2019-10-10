
import UIKit

final class RegionListRouter: RegionListDataPassing { 
  
    weak var viewController: RegionListViewController?
    var dataStore: RegionListDataStore?

}

// MARK: - RegionListRouterType 

extension RegionListRouter: RegionListRouterType {

    func routeToInstituteList(region: Region) {

        let instituteListVC = InstituteListViewController(nibName: nil, bundle: nil)
        InstituteListConfigurator.configure(viewController: instituteListVC, withRegion: region)

        viewController?.navigationController?.pushViewController(instituteListVC, animated: true)

    }

}
