
import XCTest
@testable import ProntoSoccorsoKit

final class RegioneLazioProviderTests: XCTestCase {

    var sut: RegioneLazioProvider!

    override func setUp() {
        sut = RegioneLazioProvider()
    }

    func test_parsing() throws {

        let institute = """
            {
                "ASL": "RM5",
                "BIANCHI_ATT": "0",
                "BIANCHI_OB": "0",
                "BIANCHI_TRATT": "0",
                "CODICE": "5200",
                "COMUNE": "Subiaco",
                "DATA": "2019-07-10T09:23:00",
                "GIALLI_ATT": "0",
                "GIALLI_OB": "0",
                "GIALLI_TRATT": "2",
                "ISTITUTO": "A. Angelucci",
                "NONESEG_ATT": "0",
                "NONESEG_TRATT": "0",
                "ROSSI_ATT": "0",
                "ROSSI_OB": "0",
                "ROSSI_TRATT": "0",
                "STATO_IN_PS": "ATTESA",
                "STATO_IN_PS1": "TRATTAMENTO",
                "STATO_IN_PS2": "OSSERVAZIONE_BREVE",
                "TIPO": "PS",
                "TOT_ATT": "1",
                "TOT_OB": "0",
                "TOT_RT": "0",
                "TOT_TRATT": "3",
                "TUTTI": "4",
                "VERDI_ATT": "1",
                "VERDI_OB": "0",
                "VERDI_TRATT": "1",
                "_id": 5
            }
        """

        let json = """
        {
            \"result\": {
                \"records\": [
                    \(institute)
                ]
            }
        }
        """

        let data = json.data(using: .utf8)!
        let result = try sut.mapper(data).first

        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            return formatter
        }()

        XCTAssertEqual(result?.name, "A. Angelucci")
        XCTAssertEqual(result?.municipality, "Subiaco")
        XCTAssertEqual(result?.localHealthUnit, "ASL RM5")
        XCTAssertEqual(result?.type, .generic)

        XCTAssertEqual(result?.updated, dateFormatter.date(from: "2019-07-10T09:23:00"))

        XCTAssertEqual(result?.waiting.reds, 0)
        XCTAssertEqual(result?.waiting.yellows, 0)
        XCTAssertEqual(result?.waiting.greens, 1)
        XCTAssertEqual(result?.waiting.whites, 0)
        XCTAssertEqual(result?.waiting.unassigned, 0)
        XCTAssertEqual(result?.waiting.count, 1)

        XCTAssertEqual(result?.inTreatment?.reds, 0)
        XCTAssertEqual(result?.inTreatment?.yellows, 2)
        XCTAssertEqual(result?.inTreatment?.greens, 1)
        XCTAssertEqual(result?.inTreatment?.whites, 0)
        XCTAssertEqual(result?.inTreatment?.unassigned, 0)
        XCTAssertEqual(result?.inTreatment?.count, 3)

        XCTAssertEqual(result?.inShortObservation?.reds, 0)
        XCTAssertEqual(result?.inShortObservation?.yellows, 0)
        XCTAssertEqual(result?.inShortObservation?.greens, 0)
        XCTAssertEqual(result?.inShortObservation?.whites, 0)
        XCTAssertEqual(result?.inShortObservation?.unassigned, nil)
        XCTAssertEqual(result?.inShortObservation?.count, 0)
        
        XCTAssertEqual(result?.patientsWaitingForHospitalizationOrTransfer, 0)
        XCTAssertEqual(result?.totalPatients, 4)
    }

}
