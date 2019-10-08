
import SwiftUI
import ProntoSoccorsoKit

struct TriageModifier: ViewModifier {

    let color: Color

    func body(content: Content) -> some View {
        HStack {
            if color == .white {
                Rectangle().foregroundColor(color).frame(width: 10, height: 10).border(Color.black, width: 1)
            } else {
                Rectangle().foregroundColor(color).frame(width: 10, height: 10)
            }
            content
        }
    }

}

struct TriageDataView: View {

    let text: String
    let data: HealthInstitute.TriageData

    var body: some View {
        VStack {
            Text(verbatim: text).bold()
            HStack {
                Text(verbatim: "\(data.reds)").modifier(TriageModifier(color: .red))
                Text(verbatim: "\(data.yellows)").modifier(TriageModifier(color: .yellow))
                Text(verbatim: "\(data.greens)").modifier(TriageModifier(color: .green))
                Text(verbatim: "\(data.whites)").modifier(TriageModifier(color: .white))
            }
        }
    }

}
