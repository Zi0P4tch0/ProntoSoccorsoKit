
import XCTest

class DemoAppUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func test_lazio_still_works() {
        tap("Lazio")
        waitButton("Policlinico Casilino")
    }

    func test_friuli_venezia_giulia_still_works() {
        tap("Friuli-Venezia Giulia")
        waitButton("Pronto Soccorso Gorizia")
    }

    func test_lombardia_valtellina_alto_lario_still_works() {
        tap("Lombardia (Valtellina e Alto Lario)")
        waitButton("Pronto soccorso di Sondalo")
    }

    func test_puglia_taranto_still_works() {
        tap("Puglia (Taranto)")
        waitButton("MANDURIA")
    }

    func test_trentino_alto_adige_trento_still_works() {
        tap("Trentino-Alto Adige (Trento)")
        waitButton("Ospedale di Trento - Pronto Soccorso")
    }

}


// MARK: Utilities

extension DemoAppUITests {

    func tap(_ button: String) {
        app.buttons[button].tap()
    }

    func waitButton(_ value: String, timeout: TimeInterval = 30) {
        let exp = expectation(for: NSPredicate(format: "exists = YES"),
                              evaluatedWith: app.buttons[value],
                              handler: nil)
        wait(for: [exp], timeout: timeout)
    }

}
