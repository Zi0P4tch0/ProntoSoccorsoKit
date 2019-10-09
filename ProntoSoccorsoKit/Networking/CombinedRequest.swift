
import Foundation

final class CombinedRequest {

    private let one: Request
    private let two: Request

    init(one: Request, two: Request) {
        self.one = one
        self.two = two
    }

}

// MARK: Request
extension CombinedRequest: Request {

    func fetch(with completion: @escaping (Result<[HealthInstitute], RequestError>) -> Void) {
        one.fetch { oneResult in
            switch oneResult {
            case let .success(oneInstitutes):
                self.two.fetch { twoResult in
                    switch twoResult {
                    case let .success(twoInstitutes):
                        completion(.success(oneInstitutes + twoInstitutes))
                    case let .failure(twoError):
                        completion(.failure(twoError))
                    }
                }
            case let .failure(oneError):
                completion(.failure(oneError))
            }
        }
    }

}
