
import Foundation

extension Array where Element == Request {

    func combine() -> Request? {
        guard !isEmpty else { return nil }
        guard count > 1 else { return first }
        return reduce(first!, { one, two in
            CombinedRequest(one: one, two: two)
        })
    }

}

final class CombinedRequest {

    private let one: Request
    private let two: Request

    init(one: Request, two: Request) {
        self.one = one
        self.two = two
    }

}

extension CombinedRequest: Request {

    func fetch(with completion: @escaping ([HealthInstitute]?, RequestError?) -> Void) {
        one.fetch { oneResults, oneError in
            guard let oneResults = oneResults else {
                completion(nil, oneError!)
                return
            }
            self.two.fetch { twoResults, twoError in
                guard let twoResults = twoResults else {
                    completion(nil, twoError!)
                    return
                }
                completion(oneResults + twoResults, nil)
            }
        }
    }

}
