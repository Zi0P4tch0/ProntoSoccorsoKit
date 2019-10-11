
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

        output?.updateMapLoading(response:
            Institute.MapLoading.Response(loading: true,
                                          hasAddress: institute.address != nil)
        )

        guard let address = institute.address else { return }

        CLGeocoder().geocodeAddressString(address) { [weak self] placemarks, error in
            
            guard let self = self else { return }
            guard let placemark = placemarks?.first else { return }

            DispatchQueue.main.async {
                self.output?.updateMapLoading(response:
                    Institute.MapLoading.Response(loading: false,
                                                  hasAddress: true)
                )

                self.output?.updateMapLocation(response:
                    Institute.MapLocation.Response(placemark: placemark)
                )

            }
        }

    }

}
