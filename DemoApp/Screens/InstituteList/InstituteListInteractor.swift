
import Foundation
import ProntoSoccorsoKit

final class InstituteListInteractor: InstituteListDataStore {

    var output: InstituteListInteractorOutput?

    var region: Region!

}

// MARK: InstituteListInteractorInput

extension InstituteListInteractor: InstituteListInteractorInput  {

    func viewDidLoad() {

        output?.updateTitle(response:
            InstituteList.Title.Response(region: region)
        )

        output?.updateLoading(response: InstituteList.Loading.Response(loading: true))

        ProntoSoccorso.region(region).fetch { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(institutes):
                self.output?.updateData(response: InstituteList.Data.Response(institutes: institutes))
            case let .failure(error):
                ()
            }
            self.output?.updateLoading(response: InstituteList.Loading.Response(loading: false))
        }

    }

}
