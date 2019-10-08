
import Foundation
import SwiftSoup

struct RegionePugliaTarantoProvider: Provider {

    let isScraping: Bool = true

    let urlString: String = "https://www.sanita.puglia.it/web/asl-taranto/pronto-soccorso-accesso-in-tempo-reale?p_p_id=82&p_p_lifecycle=1&p_p_state=normal&p_p_mode=view&_82_struts_action=%252Flanguage%252Fview&_82_languageId=it_IT"

    let mapper: (Data) throws -> [HealthInstitute] = { data in

        let html = String(data: data, encoding: .utf8)!
        let doc: Document = try SwiftSoup.parse(html)
        let institutions = try doc.select(".tempiPS").array()
        let now = Date()

        return try institutions.map { (institute: Element) -> HealthInstitute in

            // Name
            let name = try institute.select("thead tr").text()

            let tbody = try institute.select("tbody")

            // Waiting
            let waiting = try tbody.select("tr").at(0)
            let waitingReds = try waiting.select("td").at(1).text()
            let waitingYellows = try waiting.select("td").at(2).text()
            let waitingGreens = try waiting.select("td").at(3).text()
            let waitingWhites = try waiting.select("td").at(4).text()

            // Treatment
            let treatment = try tbody.select("tr").at(1)
            let treatmentReds = try treatment.select("td").at(1).text()
            let treatmentYellows = try treatment.select("td").at(2).text()
            let treatmentGreens = try treatment.select("td").at(3).text()
            let treatmentWhites = try treatment.select("td").at(4).text()
            
            let waitingSection = HealthInstitute.TriageData(reds: try Int(fromString: waitingReds),
                                                  yellows: try Int(fromString: waitingYellows),
                                                  greens: try Int(fromString: waitingGreens),
                                                  whites: try Int(fromString: waitingWhites),
                                                  unassigned: nil,
                                                  count: nil)
            let treatmentSection = HealthInstitute.TriageData(reds: try Int(fromString: treatmentReds),
                                                    yellows: try Int(fromString: treatmentYellows),
                                                    greens: try Int(fromString: treatmentGreens),
                                                    whites: try Int(fromString: treatmentWhites),
                                                    unassigned: nil,
                                                    count: nil)
            return HealthInstitute(name: name,
                                   municipality: "Taranto",
                                   localHealthUnit: "ASL Taranto",
                                   type: .generic,
                                   waiting: waitingSection,
                                   inTreatment: treatmentSection,
                                   inShortObservation: nil,
                                   updated: now,
                                   patientsWaitingForHospitalizationOrTransfer: nil,
                                   totalPatients: nil)
        }
    }

}
