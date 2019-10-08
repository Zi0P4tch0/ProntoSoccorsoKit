
import SwiftUI
import ProntoSoccorsoKit

let regions: [Region] = [
    .lazio,
    .puglia(.taranto),
    .friuliVeneziaGiulia,
    .lombardia(.valtellinaEAltoLario),
    .trentinoAltoAdige(.trento)
]

extension Region: Identifiable {
    public var id: String {
        switch self {
        case .lazio: return "Lazio"
        case .puglia: return "Puglia (Taranto)"
        case .friuliVeneziaGiulia: return "Friuli-Venezia Giulia"
        case .lombardia: return "Lombardia (Valtellina e Alto Lario)"
        case .trentinoAltoAdige: return "Trentino-Alto Adige (Trento)"
        }
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            List(regions) { region in
                NavigationLink(destination: InstituteListView(region)) {
                    Text(verbatim: region.id)
                }
            }
            .navigationBarTitle(Text("Pronto Soccorso"))
        }
    }
}
