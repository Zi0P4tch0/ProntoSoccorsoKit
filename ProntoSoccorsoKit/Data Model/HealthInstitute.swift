import Foundation
import CoreLocation

/// Struct representing an Italian health institute.
public struct HealthInstitute: Equatable {

    /// Institute type, according to the Italian government website.
    public enum InstituteType: Equatable {

        /// A&E/ER level I ("Dipartimento d'emergenza e d'accettazione di primo livello")
        ///
        /// In addition to the services provided by the hospitals with first aid facilities, it also guarantees the
        /// functions of observation and short hospitalization, resuscitation (through special spaces known as the
        /// red room) and must also guarantee diagnostic-therapeutic interventions of general medicine, general
        /// surgery, orthopedics and traumatology, cardiology with UTIC (Cardiological Intensive Care Unit).
        /// Furthermore, laboratory services of chemical-clinical and microbiological analysis, of diagnostic
        /// imaging, and transfusion are ensured.
        ///
        /// **Original text**:
        ///
        /// *"Garantisce oltre alle prestazioni fornite dagli ospedali sede di pronto soccorso
        /// anche le funzioni di osservazione e breve degenza, di rianimazione
        /// (attraverso spazi appositi, noti come sala rossa) e deve inoltre garantire interventi
        /// diagnostico-terapeutici di medicina generale, chirurgia generale, ortopedia e
        /// traumatologia, cardiologia con UTIC (Unità di Terapia Intensiva Cardiologica).
        /// Sono inoltre assicurate prestazioni di laboratorio di analisi chimico-cliniche
        /// e microbiologiche, di diagnostica per immagini, e trasfusionali."*
        case dea1

        /// A&E/ER level II ("Dipartimento d'emergenza e d'accettazione di secondo livello")
        ///
        /// In addition to the services provided by the DEA level I, it ensures higher qualification functions
        /// related to emergencies, including neurosurgery, cardiac surgery, neonatal intensive care, thoracic
        /// surgery and vascular surgery, according to indications established by regional programming. Other
        /// components of particular qualification, such as units for large burns or spinal units where included
        /// in the regional programming, are placed in Level II DEAs.
        ///
        /// **Original text**:
        ///
        /// *"Oltre alle prestazioni fornite dal DEA I livello, assicura funzioni di più alta
        /// qualificazione legate all'emergenza, tra cui la neurochirurgia, la cardiochirurgia,
        /// la terapia intensiva neonatale, la chirurgia toracica e la chirurgia vascolare,
        /// secondo indicazioni stabilite dalla programmazione regionale.
        ///
        /// Altre componenti di particolare qualificazione, quali le unità per grandi ustionati
        /// o le unità spinali ove rientranti nella programmazione regionale, sono collocati nei
        /// DEA di II livello."*
        case dea2

        /// Generic A&E / ER ("Pronto Soccorso")
        case generic

        /// Specialized A&E / ER ("Pronto Soccorso Specializzato").
        case specialized

        /// Unknown type.
        case unknown
    }

    /// Struct representing triage data.
    public struct TriageData: Equatable {
        /// Number of patients whose triage outcome is the red code.
        public let reds: Int
        /// Number of patients whose triage outcome is the yellow code.
        public let yellows: Int
        /// Number of patients whose triage outcome is the green code.
        public let greens: Int
        /// Number of patients whose triage outcome is the white code.
        public let whites: Int
        /// Number of patients whose triage has not yet been determined - may not be available.
        public let unassigned: Int?
        /// Tota number of patients - may not be available.
        public let count: Int?
    }

    /// Name of the institute.
    public let name: String

    /// Italian's "comune" - may not be available.
    public let municipality: String?

    /// Local health unit - may not be available.
    public let localHealthUnit: String?

    /// Institute address - may not be available.
    public let address: String?

    /// Institute type.
    public let type: InstituteType

    /// Triage data on waiting patients.
    public let waiting: TriageData

    /// Triage data on patients currently undergoing treatment - may not be available.
    public let inTreatment: TriageData?

    /// Triage data on patients placed on short observation - may not be available.
    public let inShortObservation: TriageData?

    /// Last updated date.
    public let updated: Date

    /// Number of patients waiting for hospitalization or transfer - may not be available.
    public let patientsWaitingForHospitalizationOrTransfer: Int?

    /// Total number of patients - may not be available.
    public let totalPatients: Int?

}
