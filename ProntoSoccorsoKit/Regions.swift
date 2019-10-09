
import Foundation

/// List of Italian regions.
public enum Region {
    /// Regione Lazio.
    case lazio
    /// Regione Puglia.
    case puglia(Puglia)
    /// Regione Friuli-Venezia Giulia
    case friuliVeneziaGiulia
    /// Regione Lombardia
    case lombardia(Lombardia)
    /// Regione Trentino-Alto Adige
    case trentinoAltoAdige(TrentinoAltoAdige)
}

/// Local health units of Regione Puglia.
public enum Puglia {
    /// ASL Taranto.
    case taranto
}

/// Local health units of Regione Lombardia.
public enum Lombardia {
    /// ASST Valtellina e Alto Lario
    case valtellinaEAltoLario
}

/// Local health units of Regione Trentino-Alto Adige.
public enum TrentinoAltoAdige {
    /// APSS Trento
    case trento
}
