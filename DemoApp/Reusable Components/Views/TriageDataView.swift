
import SwiftUI

private struct Triage: ViewModifier {

    let color: Color

    func body(content: Content) -> some View {
        HStack {
            Rectangle()
                .frame(width: 10, height: 10)
                .foregroundColor(color)
                .border(Color.black, width: 1)
            content
        }
    }

}

struct TriageDataView: View {

    let name: String
    let data: HealthInstitute.TriageData

    var body: some View {
        HStack {
            Text(verbatim: name).bold()
            Text(verbatim: "\(data.reds)").modifier(Triage(color: .red))
            Text(verbatim: "\(data.greens)").modifier(Triage(color: .yellow))
            Text(verbatim: "\(data.yellows)").modifier(Triage(color: .green))
            Text(verbatim: "\(data.whites)").modifier(Triage(color: .white))
        }
    }

}
