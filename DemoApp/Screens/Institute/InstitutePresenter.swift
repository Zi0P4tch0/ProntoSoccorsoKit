
import Foundation
import MapKit

final class InstitutePresenter {

    weak var output: InstitutePresenterOutput?

}

// MARK: InstitutePresenterInput

extension InstitutePresenter: InstitutePresenterInput {

    func updateData(response: Institute.Data.Response) {

        let viewModel = Institute.Data.ViewModel(
            name: response.institute.name,
            localHealthUnit: response.institute.localHealthUnit ?? "Unknown local health unit",
            municipality: response.institute.municipality ?? "Unknown municipality",
            waiting: response.institute.waiting,
            treatment: response.institute.inTreatment,
            observation: response.institute.inShortObservation
        )

        output?.presentData(viewModel: viewModel)
        
    }

}
