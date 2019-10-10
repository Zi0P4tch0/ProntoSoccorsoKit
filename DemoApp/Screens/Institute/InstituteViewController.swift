
import UIKit

final class InstituteViewController: UIViewController {

    var output: (InstituteViewOutput & InstituteDataStore)?
    var router: (InstituteRouter & InstituteDataPassing)?

}

// MARK: - InstitutePresenterOutput

extension InstituteViewController: InstitutePresenterOutput {

}
