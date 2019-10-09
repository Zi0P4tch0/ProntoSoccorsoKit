
import XCTest
@testable import ProntoSoccorsoKit

final class RegionePugliaTarantoProviderTests: XCTestCase {

    var sut: RegionePugliaTarantoProvider!

    override func setUp() {
        sut = RegionePugliaTarantoProvider()
    }

    func test_parsing() throws {

        let html = """
            <table class="tempiPS">
                <thead>
                    <tr class="dynamicBackgroundColor" style="background-color: rgb(0, 163, 191);">
                        <td colspan="5"> POC STABILIMENTO TARANTO</td>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Pazienti in attesa</td>
                        <td>
                            <div>1</div>
                        </td>
                        <td>
                            <div>6</div>
                        </td>
                        <td>
                            <div>7</div>
                        </td>
                        <td>
                            <div>9</div>
                        </td>
                    </tr>
                    <tr>
                        <td>Pazienti in visita</td>
                        <td>
                            <div>11</div>
                        </td>
                        <td>
                            <div>12</div>
                        </td>
                        <td>
                            <div>13</div>
                        </td>
                        <td>
                            <div>14</div>
                        </td>
                    </tr>
                    <tr>
                        <td>Pazienti trattati ultime 8 ore</td>
                        <td>
                            <div>3</div>
                        </td>
                        <td>
                            <div>20</div>
                        </td>
                        <td>
                            <div>20</div>
                        </td>
                        <td>
                            <div>99</div>
                        </td>
                    </tr>
                    <tr>
                        <td>Tempo medio attesa (min) ultime 8 ore</td>
                        <td>
                            <div>5</div>
                        </td>
                        <td>
                            <div>&gt;1h</div>
                        </td>
                        <td>
                            <div>&gt;2h</div>
                        </td>
                        <td>
                            <div>0</div>
                        </td>
                    </tr>
                </tbody>
            </table>
        """

        let data = html.data(using: .utf8)!
        let result = try sut.mapper(data).first

        XCTAssertEqual(result?.name, "POC STABILIMENTO TARANTO")
        XCTAssertEqual(result?.municipality, "Taranto")
        XCTAssertEqual(result?.localHealthUnit, "ASL Taranto")
        XCTAssertEqual(result?.type, .generic)

        XCTAssertEqual(result?.waiting.reds, 1)
        XCTAssertEqual(result?.waiting.yellows, 6)
        XCTAssertEqual(result?.waiting.greens, 7)
        XCTAssertEqual(result?.waiting.whites, 9)
        XCTAssertEqual(result?.waiting.unassigned, nil)
        XCTAssertEqual(result?.waiting.count, nil)

        XCTAssertEqual(result?.inTreatment?.reds, 11)
        XCTAssertEqual(result?.inTreatment?.yellows, 12)
        XCTAssertEqual(result?.inTreatment?.greens, 13)
        XCTAssertEqual(result?.inTreatment?.whites, 14)
        XCTAssertEqual(result?.inTreatment?.unassigned, nil)
        XCTAssertEqual(result?.inTreatment?.count, nil)

        XCTAssertEqual(result?.inShortObservation, nil)

        XCTAssertEqual(result?.patientsWaitingForHospitalizationOrTransfer, nil)
        XCTAssertEqual(result?.totalPatients, nil)
    }

}
