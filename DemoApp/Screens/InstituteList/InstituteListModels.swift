
import Foundation

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

    enum Error {
        struct Request { }
        struct Response { let error: Swift.Error }
        struct ViewModel {
            let title: String
            let message: String
        }
    }

    enum RowSelected {
        struct Request { let index: Int }
        struct Response { }
        struct ViewModel { }

    }

    enum Refresh {
        struct Request { }
        struct Response { }
        struct ViewModel { }
    }

    enum RefreshButtonStatus {
        struct Request { }
        struct Response { let enabled: Bool }
        struct ViewModel { let enabled: Bool }
    }

}
