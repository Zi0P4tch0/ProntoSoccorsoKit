
import Foundation
import SwiftSoup

struct RegioneFriuliVeneziaGiuliaProvider: Provider {

    let isScraping: Bool = true

    let urlString: String = "https://servizionline.sanita.fvg.it/psonline/#/index"

    let mapper: (Data) throws -> [HealthInstitute] = { data in

        let html = String(data: data, encoding: .utf8)!
        let doc: Document = try SwiftSoup.parse(html)
        let institutions = try doc.select(".prontosoccorso").array()
        let now = Date()

        return try institutions.map { (institution: Element) -> HealthInstitute in

            // Name
            let name = try institution.select(".ps_title").text()

            let table_body = try institution.select("tbody")

            // Waiting
            let red = try table_body.select("tr").at(0)
            let redWaiting = try red.select("td").at(2).text()
            let yellow = try table_body.select("tr").at(1)
            let yellowWaiting = try yellow.select("td").at(2).text()
            let green = try table_body.select("tr").at(2)
            let greenWaiting = try green.select("td").at(2).text()
            let white = try table_body.select("tr").at(3)
            let whiteWaiting = try white.select("td").at(2).text()

            // In treatment
            let redInTreatment = try red.select("td").at(1).text()
            let yellowInTreatment = try yellow.select("td").at(1).text()
            let greenInTreatment = try green.select("td").at(1).text()
            let whiteInTreatment = try white.select("td").at(1).text()

            // Total patients
            let totPatients = try institution.select(".table_footer").text()
                .replacingOccurrences(of: "Totale pazienti: ", with: "")

            let waiting = HealthInstitute.TriageData(reds: try Int(fromString: redWaiting),
                                                     yellows: try Int(fromString: yellowWaiting),
                                                     greens: try Int(fromString: greenWaiting),
                                                     whites: try Int(fromString: whiteWaiting),
                                                     unassigned: nil,
                                                     count: nil)

            let treatment = HealthInstitute.TriageData(reds: try Int(fromString: redInTreatment),
                                                       yellows: try Int(fromString: yellowInTreatment),
                                                       greens: try Int(fromString: greenInTreatment),
                                                       whites: try Int(fromString: whiteInTreatment),
                                                       unassigned: nil,
                                                       count: nil)

            return HealthInstitute(name: name,
                                   municipality: nil,
                                   localHealthUnit: nil,
                                   type: .generic,
                                   waiting: waiting,
                                   inTreatment: treatment,
                                   inShortObservation: nil,
                                   updated: now,
                                   patientsWaitingForHospitalizationOrTransfer: nil,
                                   totalPatients: try Int(fromString: totPatients))
        }
    }

}
