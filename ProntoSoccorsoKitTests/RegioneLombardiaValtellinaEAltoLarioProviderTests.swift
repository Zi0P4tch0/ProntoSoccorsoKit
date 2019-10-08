
import XCTest
@testable import ProntoSoccorsoKit

final class RegioneLombardiaValtellinaEAltoLarioProviderTests: XCTestCase {

    var sut: RegioneLombardiaValtellinaEAltoLarioProvider!

    override func setUp() {
        sut = RegioneLombardiaValtellinaEAltoLarioProvider()
    }

    func test_parsing() throws {

        let html = """
            <p><span class="text"><br><strong>Pronto soccorso di Sondrio</strong><br><br></span></p>
            <table class="table">
              <thead class="thead-inverse">
                <tr>
                  <th>Codice</th>
                  <th>In attesa</th>
                  <th>In trattamento</th>
                  <th>Tempo di attesa stimato</th>
                </tr>
              </thead>
              <tbody>
                    <tr>
                  <td><span class="cod4"></span></td>
                  <td>0</td>
                  <td>0</td>
                  <td>0 min</td>
                </tr>
                    <tr>
                  <td><span class="cod3"></span></td>
                  <td>0</td>
                  <td>0</td>
                  <td>0 min</td>
                </tr>
                    <tr>
                  <td><span class="cod2"></span></td>
                  <td>0</td>
                  <td>3</td>
                  <td>0 min</td>
                </tr>
                    <tr>
                  <td><span class="cod1"></span></td>
                  <td>0</td>
                  <td>0</td>
                  <td>0 min</td>
                </tr>
                    <tr>
                  <th>Totali</th>
                  <th>0</th>
                  <th>3</th>
                  <th></th>
                </tr>
              </tbody>
            </table>
        """

        let data = html.data(using: .utf8)!
        let result = try sut.mapper(data).first

        XCTAssertEqual(result?.name, "Pronto soccorso di Sondrio")
        XCTAssertEqual(result?.municipality, nil)
        XCTAssertEqual(result?.localHealthUnit, "ASST Valtellina e Alto Lario")
        XCTAssertEqual(result?.type, .generic)

        XCTAssertEqual(result?.waiting.reds, 0)
        XCTAssertEqual(result?.waiting.yellows, 0)
        XCTAssertEqual(result?.waiting.greens, 0)
        XCTAssertEqual(result?.waiting.whites, 0)
        XCTAssertEqual(result?.waiting.unassigned, nil)
        XCTAssertEqual(result?.waiting.count, 0)

        XCTAssertEqual(result?.inTreatment?.reds, 0)
        XCTAssertEqual(result?.inTreatment?.yellows, 0)
        XCTAssertEqual(result?.inTreatment?.greens, 3)
        XCTAssertEqual(result?.inTreatment?.whites, 0)
        XCTAssertEqual(result?.inTreatment?.unassigned, nil)
        XCTAssertEqual(result?.inTreatment?.count, 3)

        XCTAssertEqual(result?.inShortObservation, nil)

        XCTAssertEqual(result?.patientsWaitingForHospitalizationOrTransfer, nil)
        XCTAssertEqual(result?.totalPatients, nil)
    }

}
