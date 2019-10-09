
import UIKit

final class RegionListRouter: RegionListDataPassing { 
  
    weak var viewController: RegionListViewController?
    var dataStore: RegionListDataStore?

}

// MARK: - RegionListRouterType 

extension RegionListRouter: RegionListRouterType {

}
