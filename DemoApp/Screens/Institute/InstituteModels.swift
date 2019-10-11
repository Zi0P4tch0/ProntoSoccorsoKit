
import Foundation
import CoreLocation
import MapKit

enum Institute {

    enum Data {
        struct Request { }
        struct Response { let institute: HealthInstitute }
        struct ViewModel {
            let name: String
            let localHealthUnit: String
            let municipality: String
            let waiting: HealthInstitute.TriageData
            let treatment: HealthInstitute.TriageData?
            let observation: HealthInstitute.TriageData?
        }
    }

    enum MapLoading {
        struct Request { }
        struct Response {
            let loading: Bool
            let hasAddress: Bool
        }
        struct ViewModel {
            let loading: Bool
            let message: String?
        }
    }

    enum MapLocation {
        struct Request { }
        struct Response { let placemark: CLPlacemark }
        struct ViewModel {
            let region: MKCoordinateRegion
            let annotation: MKPointAnnotation
        }
    }
  
}
