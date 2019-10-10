
import Foundation
import CoreLocation

final class InstituteInteractor: InstituteDataStore {

    var output: InstituteInteractorOutput?

    var institute: HealthInstitute!

}

// MARK: InstituteInteractorInput

extension InstituteInteractor: InstituteInteractorInput  {

    func viewDidLoad() {

        output?.updateData(response:
            Institute.Data.Response(institute: institute)
        )

    }

}
