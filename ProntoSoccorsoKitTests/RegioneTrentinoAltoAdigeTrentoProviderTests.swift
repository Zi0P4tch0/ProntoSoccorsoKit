
import XCTest
@testable import ProntoSoccorsoKit

final class RegioneTrentinoAltoAdigeTrentoProviderTests: XCTestCase {

    var sut: RegioneTrentinoAltoAdigeTrentoProvider!

    override func setUp() {
        sut = RegioneTrentinoAltoAdigeTrentoProvider()
    }

    func test_parsing() throws {

        let html = """
           <div class="statops">
            <div class="row" style="margin-top: 5px; padding-top: 5px; border-top: 1px solid black"><div class="col-xs-5 text-left">Ospedale di Arco - Pronto Soccorso</div><div class="col-xs-3"><div class="row"><div class="col-xs-3 white">0</div><div class="col-xs-3 green">2</div><div class="col-xs-3 yellow">0</div><div class="col-xs-3 red">0</div></div></div><div class="col-xs-1"></div><div class="col-xs-3"><div class="row"><div class="col-xs-3 white">1</div><div class="col-xs-3 green">0</div><div class="col-xs-3 yellow">2</div><div class="col-xs-3 red">0</div></div></div></div>
           </div>
        """

        let data = html.data(using: .utf8)!
        let result = try sut.mapper(data).first

        XCTAssertEqual(result?.name, "Ospedale di Arco - Pronto Soccorso")
        XCTAssertEqual(result?.municipality, "Trento")
        XCTAssertEqual(result?.localHealthUnit, "ASSP Provincia Di Trento")
        XCTAssertEqual(result?.type, .generic)

        XCTAssertEqual(result?.waiting.reds, 0)
        XCTAssertEqual(result?.waiting.yellows, 0)
        XCTAssertEqual(result?.waiting.greens, 2)
        XCTAssertEqual(result?.waiting.whites, 0)
        XCTAssertEqual(result?.waiting.unassigned, nil)
        XCTAssertEqual(result?.waiting.count, nil)

        XCTAssertEqual(result?.inTreatment?.reds, 0)
        XCTAssertEqual(result?.inTreatment?.yellows, 2)
        XCTAssertEqual(result?.inTreatment?.greens, 0)
        XCTAssertEqual(result?.inTreatment?.whites, 1)
        XCTAssertEqual(result?.inTreatment?.unassigned, nil)
        XCTAssertEqual(result?.inTreatment?.count, nil)

        XCTAssertEqual(result?.inShortObservation, nil)

        XCTAssertEqual(result?.patientsWaitingForHospitalizationOrTransfer, nil)
        XCTAssertEqual(result?.totalPatients, nil)
    }

}

