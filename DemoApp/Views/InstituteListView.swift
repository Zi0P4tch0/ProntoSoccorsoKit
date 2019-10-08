
import SwiftUI
import ProntoSoccorsoKit
import Combine

final class InstituteListViewModel: ObservableObject {

    @Published var isLoading: Bool = false
    @Published var institutes: [HealthInstitute] = []

    private let region: Region
    private var bag: AnyCancellable?

    init(region: Region) {
        self.region = region
    }

    func onAppear() {

        guard bag == nil else { return }

        isLoading = true

        bag = Future<[HealthInstitute], RequestError> { promise in
            ProntoSoccorso.region(self.region).fetch { institutes, error in
                guard let institutes = institutes else {
                    promise(.failure(error!))
                    return
                }
                promise(.success(institutes))
            }
        }
        .replaceError(with: [])
        .receive(on: RunLoop.main)
        .print()
        .handleEvents(receiveCompletion: { _ in self.isLoading.toggle() })
        .assign(to: \.institutes, on: self)

    }

}

struct InstituteListView: View {

    @ObservedObject var viewModel: InstituteListViewModel

    private let region: Region

    init(_ region: Region) {
        self.region = region
        viewModel = InstituteListViewModel(region: region)
    }

    var body: some View {
        Group {
            if viewModel.isLoading {
                Text("Loading data...")
            } else {
                List(viewModel.institutes, id: \.name) { institute in
                    NavigationLink(destination: InstituteView(institute)) {
                        Text(verbatim: institute.name)
                    }
                }
            }
        }
        .onAppear(perform: viewModel.onAppear)
        .navigationBarTitle(Text(verbatim: region.id), displayMode: .inline)
    }

}
