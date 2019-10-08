
import Foundation
import WebKit

public enum RequestError: Error {
    case local(Error)
    case deserialization(Error)
    case scraping(Error)
    case remote(Int)
}

public protocol Request {
    func fetch(with completion: @escaping (Result<[HealthInstitute], RequestError>) -> Void)
}

final class RequestImplementation {

    let isScraping: Bool
    let url: URL
    let mapper: (Data) throws -> [HealthInstitute]

    var scraper: Scraper?

    init(for region: Region) {
        let provider = region.provider
        isScraping = provider.isScraping
        url = URL(string: provider.urlString)!
        mapper = provider.mapper
    }

}


// MARK: - WebserviceType
extension RequestImplementation: Request {

    public func fetch(with completion: @escaping (Result<[HealthInstitute], RequestError>) -> Void) {

        if isScraping {
            scraper = Scraper(url: url, mapper: mapper, completion: completion)
            scraper!.scrape() {
                self.scraper = nil
            }
        } else {
            GET(with: completion)
        }

    }

    private func GET(with completion: @escaping (Result<[HealthInstitute], RequestError>) -> Void) {

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async { completion(.failure(.local(error))) }
            } else {
                let statusCode = (response as! HTTPURLResponse).statusCode
                if 200...299 ~= statusCode {
                    do {
                        let institutes = try self.mapper(data!)
                        DispatchQueue.main.async { completion(.success(institutes)) }
                    } catch {
                        DispatchQueue.main.async { completion(.failure(.deserialization(error))) }
                    }
                } else {
                    DispatchQueue.main.async { completion(.failure(.remote(statusCode))) }
                }
            }


        }.resume()

    }


}
