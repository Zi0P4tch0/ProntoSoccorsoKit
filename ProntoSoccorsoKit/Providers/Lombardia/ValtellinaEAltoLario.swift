
import Foundation
import SwiftSoup

struct RegioneLombardiaValtellinaEAltoLarioProvider: Provider {

    let isScraping: Bool = true

    let urlString: String = "http://www.asst-val.it/11705_TEST_Tempi_di_attesa_pronto_soccorso.html"

    let mapper: (Data) throws -> [HealthInstitute] = { data in

        let html = String(data: data, encoding: .utf8)!
        let doc: Document = try SwiftSoup.parse(html)
        let names = try doc.select("p").array().map { try $0.text() }.filter {
            $0.starts(with: "Pronto soccorso di")
        }
        let tables = try doc.select("table").array()
        let now = Date()

        let institutes = try zip(names, tables).map { tuple -> HealthInstitute in
            let tbody = try tuple.1.select("tbody")
            let rows = try tbody.select("tr").array()
            let reds = try rows.at(0)
            let redsWaiting = try reds.select("td").array().at(1).text()
            let redsInTreatment = try reds.select("td").array().at(2).text()
            let yellows = try rows.at(1)
            let yellowsWaiting = try yellows.select("td").array().at(1).text()
            let yellowsInTreatment = try yellows.select("td").array().at(2).text()
            let greens = try rows.at(2)
            let greensWaiting = try greens.select("td").array().at(1).text()
            let greensInTreatment = try greens.select("td").array().at(2).text()
            let whites = try rows.at(3)
            let whitesWaiting = try whites.select("td").array().at(1).text()
            let whitesInTreatment = try whites.select("td").array().at(2).text()
            let totals = try rows.at(4)
            let totalWaiting = try totals.select("th").array().at(1).text()
            let totalInTreament = try totals.select("th").array().at(2).text()

            let waiting = HealthInstitute.TriageData(reds: try Int(fromString: redsWaiting),
                                                     yellows: try Int(fromString: yellowsWaiting),
                                                     greens: try Int(fromString: greensWaiting),
                                                     whites: try Int(fromString: whitesWaiting),
                                                     unassigned: nil,
                                                     count: try Int(fromString: totalWaiting))

            let treatment = HealthInstitute.TriageData(reds: try Int(fromString: redsInTreatment),
                                                       yellows: try Int(fromString: yellowsInTreatment),
                                                       greens: try Int(fromString: greensInTreatment),
                                                       whites: try Int(fromString: whitesInTreatment),
                                                       unassigned: nil,
                                                       count: try Int(fromString: totalInTreament))
            

            return HealthInstitute(name: tuple.0,
                                   municipality: nil,
                                   localHealthUnit: "ASST Valtellina e Alto Lario",
                                   address: nil,
                                   type: .generic,
                                   waiting: waiting,
                                   inTreatment: treatment,
                                   inShortObservation: nil,
                                   updated: now,
                                   patientsWaitingForHospitalizationOrTransfer: nil,
                                   totalPatients: nil)
        }

        return institutes
    }

}
