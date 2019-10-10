
import UIKit

final class InstituteListViewController: UIViewController {

    var output: (InstituteListViewOutput & InstituteListDataStore)?
    var router: (InstituteListRouter & InstituteListDataPassing)?

    // MARK: - Views

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: "LabelTableViewCell", bundle: nil),
                               forCellReuseIdentifier: LabelTableViewCell.identifier)
            tableView.delegate = self
        }
    }

    var dataSource: TableViewDataSource<LabelTableViewCell>! {
        didSet {
            tableView.dataSource = dataSource
            tableView.reloadData()
        }
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh,
                                                            target: self,
                                                            action: #selector(refreshTapped))

        output?.viewDidLoad()
    }

}

// MARK: - InstituteListPresenterOutput

extension InstituteListViewController: InstituteListPresenterOutput {

    func presentTitle(viewModel: InstituteList.Title.ViewModel) {
        title = viewModel.title
    }

    func presentData(viewModel: InstituteList.Data.ViewModel) {
        dataSource = TableViewDataSource(viewModels: viewModel.institutes)
    }

    func presentLoading(viewModel: InstituteList.Loading.ViewModel) {
        if viewModel.loading {
            LoadingView.show(on: view)
        } else {
            LoadingView.hide(from: view)
        }
    }

    func presentError(viewModel: InstituteList.Error.ViewModel) {

        let alert = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))

        present(alert, animated: true, completion:  nil)

    }

    func routeToInstitute(institute: HealthInstitute) {
        router?.routeToInstitute(institute: institute)
    }

    func presentRefreshButtonStatus(viewModel: InstituteList.RefreshButtonStatus.ViewModel) {

        navigationItem.rightBarButtonItem?.isEnabled = viewModel.enabled

    }

}

// MARK: - UITableViewDelegate

extension InstituteListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output?.rowSelected(request:
            InstituteList.RowSelected.Request(index: indexPath.row)
        )
    }

}

// MARK: - Actions

extension InstituteListViewController {

    @objc func refreshTapped() {
        output?.refreshTapped()
    }

}
