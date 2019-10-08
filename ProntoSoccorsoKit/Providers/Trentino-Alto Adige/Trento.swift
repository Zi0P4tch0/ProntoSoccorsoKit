
import Foundation
import SwiftSoup

struct RegioneTrentinoAltoAdigeTrentoProvider: Provider {

    let isScraping: Bool = true

    let urlString: String = "https://servizi.apss.tn.it/statops/"

    let mapper: (Data) throws -> [HealthInstitute] = { data in

        let html = String(data: data, encoding: .utf8)!
        let doc: Document = try SwiftSoup.parse(html)
        let rows = try doc.select(".statops > .row").array()
        let now = Date()

        return try rows.map { (institute: Element) -> HealthInstitute in

            // Name
            let name = try institute.select("div .text-left").text()

            let type: HealthInstitute.InstituteType = {
                if name.contains("Oculistico") ||
                   name.contains("Ginecologico") ||
                   name.contains("Ortopedico") ||
                   name.contains("Pediatrico") {
                    return .specialized
                }
                return .generic
            }()

            let waiting = try institute.select("div .col-xs-3").array().at(0)
            let inTreatment = try institute.select("div .col-xs-3").array().at(5)

            let redsInWaiting = try waiting.select(".red").text()
            let yellowsInWaiting = try waiting.select(".yellow").text()
            let greensInWaiting = try waiting.select(".green").text()
            let whitesInWaiting = try waiting.select(".white").text()

            let redsInTreatment = try inTreatment.select(".red").text()
            let yellowsInTreatment = try inTreatment.select(".yellow").text()
            let greensInTreatment = try inTreatment.select(".green").text()
            let whitesInTreatment = try inTreatment.select(".white").text()

            let waitingSection = HealthInstitute.TriageData(reds: try Int(fromString: redsInWaiting),
                                                  yellows: try Int(fromString: yellowsInWaiting),
                                                  greens: try Int(fromString: greensInWaiting),
                                                  whites: try Int(fromString: whitesInWaiting),
                                                  unassigned: nil,
                                                  count: nil)

            let treatmentSection = HealthInstitute.TriageData(reds: try Int(fromString: redsInTreatment),
                                                    yellows: try Int(fromString: yellowsInTreatment),
                                                    greens: try Int(fromString: greensInTreatment),
                                                    whites: try Int(fromString: whitesInTreatment),
                                                    unassigned: nil,
                                                    count: nil)
            return HealthInstitute(name: name,
                                   municipality: "Trento",
                                   localHealthUnit: "ASSP Provincia Di Trento",
                                   type: type,
                                   waiting: waitingSection,
                                   inTreatment: treatmentSection,
                                   inShortObservation: nil,
                                   updated: now,
                                   patientsWaitingForHospitalizationOrTransfer: nil,
                                   totalPatients: nil)
        }
    }

}
