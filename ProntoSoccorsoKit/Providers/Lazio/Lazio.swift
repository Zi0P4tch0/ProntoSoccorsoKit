import Foundation

// MARK: - Regione Lazio Responses
private struct Institute: Decodable {
    let _id: Int
    let COMUNE: String
    let BIANCHI_TRATT: String
    let NONESEG_TRATT: String
    let TUTTI: String
    let DATA: String
    let TOT_ATT: String
    let CODICE: String
    let TIPO: String
    let ROSSI_TRATT: String
    let TOT_OB: String
    let TOT_RT: String
    let ROSSI_OB: String
    let VERDI_OB: String
    let TOT_TRATT: String
    let GIALLI_ATT: String
    let ASL: String
    let GIALLI_OB: String
    let GIALLI_TRATT: String
    let NONESEG_ATT: String
    let BIANCHI_ATT: String
    let BIANCHI_OB: String
    let VERDI_TRATT: String
    let ROSSI_ATT: String
    let ISTITUTO: String
    let VERDI_ATT: String
}

private struct Result: Decodable {
    let records: [Institute]
}

private struct Response: Decodable {
    let result: Result
}

// MARK - Provider Regione Lazio
struct RegioneLazioProvider: Provider {

    let isScraping: Bool = false

    let urlString: String = "http://dati.lazio.it/catalog/api/action/datastore_search?resource_id=12c31624-f1a4-4874-a903-8954549ddb81"

    let mapper: (Data) throws -> [HealthInstitute] = { data in
        let response = try JSONDecoder().decode(Response.self, from: data)
        return try response.result.records.map { try HealthInstitute(from: $0) }
    }
}

// MARK: - Istituto.Tipo + Regione Lazio
private extension HealthInstitute.InstituteType {

    static func from(tipo: String) -> HealthInstitute.InstituteType {
        switch tipo {
        case "DEA I": return .dea1
        case "DEA II": return .dea2
        case "PS": return .generic
        case "PS SPEC.": return .specialized
        default: return .unknown
        }
    }

}

// MARK: - Istituto + Regione Lazio

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    return formatter
}()

private extension HealthInstitute {

    init(from raw: Institute) throws {

        name = raw.ISTITUTO
        type = HealthInstitute.InstituteType.from(tipo: raw.TIPO)
        municipality = raw.COMUNE
        localHealthUnit = "ASL \(raw.ASL)"
        updated = try dateFormatter.date(fromString: raw.DATA)
        totalPatients = try Int(fromString: raw.TUTTI)
        patientsWaitingForHospitalizationOrTransfer = try Int(fromString: raw.TOT_RT)

        let waiting = TriageData(reds: try Int(fromString: raw.ROSSI_ATT),
                             yellows: try Int(fromString: raw.GIALLI_ATT),
                             greens: try Int(fromString: raw.VERDI_ATT),
                             whites: try Int(fromString: raw.BIANCHI_ATT),
                             unassigned: try Int(fromString: raw.NONESEG_ATT),
                             count: try Int(fromString: raw.TOT_ATT))

        let treatment = TriageData(reds: try Int(fromString: raw.ROSSI_TRATT),
                                  yellows: try Int(fromString: raw.GIALLI_TRATT),
                                  greens: try Int(fromString: raw.VERDI_TRATT),
                                  whites: try Int(fromString: raw.BIANCHI_TRATT),
                                  unassigned: try Int(fromString: raw.NONESEG_TRATT),
                                  count: try Int(fromString:raw.TOT_TRATT))

        let observation = TriageData(reds: try Int(fromString:raw.ROSSI_OB),
                                   yellows: try Int(fromString:raw.GIALLI_OB),
                                   greens: try Int(fromString:raw.VERDI_OB),
                                   whites: try Int(fromString:raw.BIANCHI_OB),
                                   unassigned: nil,
                                   count: try Int(fromString:raw.TOT_OB))

        self.waiting = waiting
        inTreatment = treatment
        inShortObservation = observation

    }

}
