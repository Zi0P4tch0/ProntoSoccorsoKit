
import Foundation
import MapKit

final class InstitutePresenter {

    weak var output: InstitutePresenterOutput?

}

// MARK: InstitutePresenterInput

extension InstitutePresenter: InstitutePresenterInput {

    func updateData(response: Institute.Data.Response) {

        let viewModel = Institute.Data.ViewModel(
            name: response.institute.name,
            localHealthUnit: response.institute.localHealthUnit ?? "Unknown local health unit",
            municipality: response.institute.municipality ?? "Unknown municipality",
            waiting: response.institute.waiting,
            treatment: response.institute.inTreatment,
            observation: response.institute.inShortObservation
        )

        output?.presentData(viewModel: viewModel)
        
    }

    func updateMapLoading(response: Institute.MapLoading.Response) {

        output?.presentMapLoading(viewModel:
            Institute.MapLoading.ViewModel(loading: response.loading,
                                           message: response.hasAddress ? nil : "No known address for institute.")
        )

    }

    func updateMapLocation(response: Institute.MapLocation.Response) {

        let region = MKCoordinateRegion(center: response.placemark.location!.coordinate,
                                        latitudinalMeters: 300,
                                        longitudinalMeters: 300)

        var pin = MKPointAnnotation()
        pin.coordinate = response.placemark.location!.coordinate

        output?.presentMapLocation(viewModel:
            Institute.MapLocation.ViewModel(region: region, annotation: pin)
        )

    }

}
