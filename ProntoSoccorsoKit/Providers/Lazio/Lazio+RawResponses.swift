
import Foundation

// MARK: - Regione Lazio Responses

struct LazioInstitute: Decodable {
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

struct LazioResult: Decodable {
    let records: [LazioInstitute]
}

struct LazioResponse: Decodable {
    let result: LazioResult
}

