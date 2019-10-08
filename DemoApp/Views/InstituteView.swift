
import SwiftUI
import ProntoSoccorsoKit

struct InstituteView: View {

    let institute: HealthInstitute

    init(_ institute: HealthInstitute) {
        self.institute = institute
    }

    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("Type: ").bold()
                    Text(verbatim: String(describing: institute.type))
                }
                HStack {
                    Text("Municipality: ").bold()
                    Text(verbatim: institute.municipality  ?? "???")
                }
                HStack {
                    Text("Local health unit: ").bold()
                    Text(verbatim: institute.localHealthUnit ?? "???")
                }
            }
            Group {
                TriageDataView(text: "Waiting:", data: institute.waiting)
                if institute.inTreatment != nil {
                    TriageDataView(text: "In Treatment:", data: institute.inTreatment!)
                }
                if institute.inShortObservation != nil {
                    TriageDataView(text: "In Short Observation:", data: institute.inShortObservation!)
                }
            }.offset(x: 0, y: 32)
        }
        .navigationBarTitle(Text(verbatim: institute.name), displayMode: .inline)
    }

}
