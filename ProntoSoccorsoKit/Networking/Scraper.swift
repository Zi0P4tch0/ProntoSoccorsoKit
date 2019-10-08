
import Foundation
import WebKit

final class Scraper: NSObject {

    lazy var webView: WKWebView = {
        let webView = WKWebView(frame: UIScreen.main.bounds)
        webView.navigationDelegate = self
        webView.alpha = 0.01
        return webView
    }()

    private let url: URL
    private let mapper: (Data) throws -> [HealthInstitute]
    private let completion: ([HealthInstitute]?, RequestError?) -> Void
    private var whenDone: (() -> Void)?

    init(url: URL,
         mapper: @escaping (Data) throws -> [HealthInstitute],
         completion: @escaping ([HealthInstitute]?, RequestError?) -> Void) {
        self.url = url
        self.mapper = mapper
        self.completion = completion
    }

    deinit {
        webView.removeFromSuperview()
    }

    func scrape(whenDone: (() -> Void)? = nil) {
        self.whenDone = whenDone
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else  {
                fatalError("No key window!")
            }
            window.insertSubview(self.webView, at: 0)
            self.webView.load(URLRequest(url: self.url))
        }
    }

}

extension Scraper: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {

        defer { whenDone?() }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            webView.evaluateJavaScript("document.getElementsByTagName('html')[0].innerHTML") { innerHTML, error in
                if let error = error {
                    DispatchQueue.main.async { self.completion(nil, RequestError.scraping(error)) }
                } else {
                    do {
                        let htmlString = (innerHTML as? String) ?? ""
                        let data = htmlString.data(using: .utf8)!
                        let result = try self.mapper(data)
                        DispatchQueue.main.async { self.completion(result, nil) }
                    } catch {
                        DispatchQueue.main.async { self.completion(nil, RequestError.deserialization(error)) }
                    }
                }
            }
        }
        
    }

}
