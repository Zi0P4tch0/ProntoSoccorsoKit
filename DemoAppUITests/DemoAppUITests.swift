
import XCTest

class DemoAppUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func test_lazio_still_works() {
        app.buttons["Lazio"].tap()
        let exp = expectation(for: NSPredicate(format: "exists = YES"),
                              evaluatedWith: app.buttons["Policlinico Casilino"],
                              handler: nil)
        wait(for: [exp], timeout: 30)
    }

    func test_friuli_venezia_giulia_still_works() {
        app.buttons["Friuli-Venezia Giulia"].tap()
        let exp = expectation(for: NSPredicate(format: "exists = YES"),
                              evaluatedWith: app.buttons["Pronto Soccorso Gorizia"],
                              handler: nil)
        wait(for: [exp], timeout: 30)
    }

    func test_lombardia_valtellina_alto_lario_still_works() {
        app.buttons["Lombardia (Valtellina e Alto Lario)"].tap()
        let exp = expectation(for: NSPredicate(format: "exists = YES"),
                              evaluatedWith: app.buttons["Pronto soccorso di Sondalo"],
                              handler: nil)
        wait(for: [exp], timeout: 30)
    }

    func test_puglia_taranto_still_works() {
        app.buttons["Puglia (Taranto)"].tap()
        let exp = expectation(for: NSPredicate(format: "exists = YES"),
                              evaluatedWith: app.buttons["MANDURIA"],
                              handler: nil)
        wait(for: [exp], timeout: 30)
    }

    func test_trentino_alto_adige_trento_still_works() {
        app.buttons["Trentino-Alto Adige (Trento)"].tap()
        let exp = expectation(for: NSPredicate(format: "exists = YES"),
                              evaluatedWith: app.buttons["Ospedale di Trento - Pronto Soccorso"],
                              handler: nil)
        wait(for: [exp], timeout: 30)
    }

}
