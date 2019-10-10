
import Foundation
import ProntoSoccorsoKit

enum InstituteList {

    enum Title {
        struct Request { }
        struct Response { let region: Region }
        struct ViewModel { let title: String }
    }

    enum Data {
        struct Request { }
        struct Response { let institutes: [HealthInstitute] }
        struct ViewModel { let institutes: [String] }
    }

    enum Loading {
        struct Request { }
        struct Response { let loading: Bool }
        struct ViewModel { let loading: Bool }
    }

}
