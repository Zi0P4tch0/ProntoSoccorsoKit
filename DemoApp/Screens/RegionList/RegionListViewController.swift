
import UIKit

final class RegionListViewController: UIViewController {

    var output: (RegionListViewOutput & RegionListDataStore)?
    var router: (RegionListRouter & RegionListDataPassing)?

    // MARK: - Views

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: "LabelTableViewCell", bundle: nil),
                               forCellReuseIdentifier: LabelTableViewCell.identifier)
            tableView.delegate = self
        }
    }

    // MARK: - Data Source

    var dataSource: TableViewDataSource<LabelTableViewCell>! {
        didSet {
            tableView.dataSource = dataSource
            tableView.reloadData()
        }
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ProntoSoccorso"
        output?.viewDidLoad()
    }

}

// MARK: - RegionListPresenterOutput

extension RegionListViewController: RegionListPresenterOutput {

    func presentData(viewModel: RegionList.Data.ViewModel) {
        dataSource = TableViewDataSource(viewModels: viewModel.regions)
    }

}

// MARK: - UITableViewDelegate

extension RegionListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

}
