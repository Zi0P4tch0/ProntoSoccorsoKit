
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

/// Region of Puglia.
public enum Puglia {
    /// ASL Taranto.
    case taranto
}

public enum Lombardia {
    /// ASST Valtellina e Alto Lario
    case valtellinaEAltoLario
}

public enum TrentinoAltoAdige {
    /// APSS Trento
    case trento
}
