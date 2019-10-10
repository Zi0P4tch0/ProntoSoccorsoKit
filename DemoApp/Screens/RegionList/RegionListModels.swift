
import Foundation

enum RegionList {

    enum Data {
        struct Request { }
        struct Response { let regions: [Region] }
        struct ViewModel { let regions: [String] }
    }

    enum RowSelected {
        struct Request { let index: Int }
        struct Response { }
        struct ViewModel { }
        
    }
  
}
