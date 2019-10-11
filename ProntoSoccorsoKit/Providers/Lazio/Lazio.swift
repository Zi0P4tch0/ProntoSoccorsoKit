import Foundation

// MARK - Provider Regione Lazio
struct RegioneLazioProvider: Provider {

    let isScraping: Bool = false

    let urlString: String = "http://dati.lazio.it/catalog/api/action/datastore_search?resource_id=12c31624-f1a4-4874-a903-8954549ddb81"

    let mapper: (Data) throws -> [HealthInstitute] = { data in
        let response = try JSONDecoder().decode(LazioResponse.self, from: data)
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

    init(from raw: LazioInstitute) throws {

        name = lazioNames[raw.ISTITUTO] ?? raw.ISTITUTO
        type = HealthInstitute.InstituteType.from(tipo: raw.TIPO)
        municipality = raw.COMUNE
        localHealthUnit = "ASL \(raw.ASL)"
        address = lazioAddresses[raw.ISTITUTO] 
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
