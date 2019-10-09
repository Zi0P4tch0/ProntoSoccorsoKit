
import XCTest
@testable import ProntoSoccorsoKit

final class RegioneLazioProviderTests: XCTestCase {

    var sut: RegioneLazioProvider!

    override func setUp() {
        sut = RegioneLazioProvider()
    }

    func json(instituteType: String = "PS") -> String {

        let institute = """
            {
                "ASL": "RM5",
                "BIANCHI_ATT": "7",
                "BIANCHI_OB": "1",
                "BIANCHI_TRATT": "73",
                "CODICE": "5200",
                "COMUNE": "Subiaco",
                "DATA": "2019-07-10T09:23:00",
                "GIALLI_ATT": "23",
                "GIALLI_OB": "1234",
                "GIALLI_TRATT": "3",
                "ISTITUTO": "A. Angelucci",
                "NONESEG_ATT": "44",
                "NONESEG_TRATT": "45",
                "ROSSI_ATT": "67",
                "ROSSI_OB": "69",
                "ROSSI_TRATT": "2",
                "STATO_IN_PS": "ATTESA",
                "STATO_IN_PS1": "TRATTAMENTO",
                "STATO_IN_PS2": "OSSERVAZIONE_BREVE",
                "TIPO": "\(instituteType)",
                "TOT_ATT": "100",
                "TOT_OB": "1",
                "TOT_RT": "123",
                "TOT_TRATT": "1234",
                "TUTTI": "5000",
                "VERDI_ATT": "31",
                "VERDI_OB": "32",
                "VERDI_TRATT": "33",
                "_id": 54
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

        return json
    }

    func test_parsing() throws {

        let data = json().data(using: .utf8)!
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

        XCTAssertEqual(result?.waiting.reds, 67)
        XCTAssertEqual(result?.waiting.yellows, 23)
        XCTAssertEqual(result?.waiting.greens, 31)
        XCTAssertEqual(result?.waiting.whites, 7)
        XCTAssertEqual(result?.waiting.unassigned, 44)
        XCTAssertEqual(result?.waiting.count, 100)

        XCTAssertEqual(result?.inTreatment?.reds, 2)
        XCTAssertEqual(result?.inTreatment?.yellows, 3)
        XCTAssertEqual(result?.inTreatment?.greens, 33)
        XCTAssertEqual(result?.inTreatment?.whites, 73)
        XCTAssertEqual(result?.inTreatment?.unassigned, 45)
        XCTAssertEqual(result?.inTreatment?.count, 1234)

        XCTAssertEqual(result?.inShortObservation?.reds, 69)
        XCTAssertEqual(result?.inShortObservation?.yellows, 1234)
        XCTAssertEqual(result?.inShortObservation?.greens, 32)
        XCTAssertEqual(result?.inShortObservation?.whites, 1)
        XCTAssertEqual(result?.inShortObservation?.unassigned, nil)
        XCTAssertEqual(result?.inShortObservation?.count, 1)
        
        XCTAssertEqual(result?.patientsWaitingForHospitalizationOrTransfer, 123)
        XCTAssertEqual(result?.totalPatients, 5000)
    }

}
