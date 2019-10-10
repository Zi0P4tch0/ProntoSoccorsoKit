
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
  
}
