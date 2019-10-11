
import UIKit
import SwiftUI
import MapKit

final class InstituteViewController: UIViewController {

    var output: (InstituteViewOutput & InstituteDataStore)?
    var router: (InstituteRouter & InstituteDataPassing)?

    // MARK: - Views

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var localHealthUnitLabel: UILabel!
    @IBOutlet private weak var municipalityLabel: UILabel!

    @IBOutlet private weak var waitingContainerView: UIView! {
        didSet {
            $waitingView.parent = self
            $waitingView.container = \.waitingContainerView
        }
    }

    @IBOutlet private weak var treatmentContainerView: UIView! {
        didSet {
            $treatmentView.parent = self
            $treatmentView.container = \.treatmentContainerView
        }
    }

    @IBOutlet private weak var observationContainerView: UIView! {
        didSet {
            $observationView.parent = self
            $observationView.container = \.observationContainerView
        }
    }

    @IBOutlet private weak var mapView: MKMapView! {
        didSet {
            mapView.showsTraffic = true
        }
    }

    @SwiftUIView<TriageDataView, InstituteViewController>
    var waitingView: TriageDataView?

    @SwiftUIView<TriageDataView, InstituteViewController>
    var treatmentView: TriageDataView?

    @SwiftUIView<TriageDataView, InstituteViewController>
    var observationView: TriageDataView?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        waitingView = nil
        treatmentView = nil
    }

}

// MARK: - InstitutePresenterOutput

extension InstituteViewController: InstitutePresenterOutput {

    func presentData(viewModel: Institute.Data.ViewModel) {
        
        nameLabel.text = viewModel.name
        localHealthUnitLabel.text = viewModel.localHealthUnit
        municipalityLabel.text = viewModel.municipality

        waitingView = TriageDataView(name: "Waiting: ", data: viewModel.waiting)

        if let treatmentData = viewModel.treatment {
            treatmentView = TriageDataView(name: "In treatment: ", data: treatmentData)
        }

        if let observationData = viewModel.observation {
            observationView = TriageDataView(name: "In observation: ", data: observationData)
        }

    }

    func presentMapLoading(viewModel: Institute.MapLoading.ViewModel) {
        if viewModel.loading {
            LoadingView.show(on: mapView)
            if let message = viewModel.message {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    LoadingView.stopAndShowMessage(message, on: self.mapView)
                }
            }
        } else {
            LoadingView.hide(from: mapView)
        }
    }

    func presentMapLocation(viewModel: Institute.MapLocation.ViewModel) {

        mapView.addAnnotation(viewModel.annotation)
        mapView.setRegion(viewModel.region, animated: true)

    }
}
