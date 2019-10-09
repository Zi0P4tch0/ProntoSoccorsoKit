
import Foundation
import ProntoSoccorsoKit

enum RegionList {

    enum Data {
        struct Request { }
        struct Response { let regions: [Region] }
        struct ViewModel { let regions: [String] }
    }
  
}
