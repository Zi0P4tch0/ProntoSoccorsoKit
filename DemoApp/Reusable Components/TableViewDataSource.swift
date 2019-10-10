
import UIKit

protocol Cell {
    associatedtype ViewModel
    var viewModel: ViewModel! { get set }
}

protocol DisclosableCell { }

extension Cell where Self: UITableViewCell {
    static var identifier: String {
        String(describing: type(of: self))
    }
}

final class TableViewDataSource<TableCell>: NSObject, UITableViewDataSource where TableCell: UITableViewCell & Cell {

    let viewModels: [TableCell.ViewModel]

    init(viewModels: [TableCell.ViewModel]) {
        self.viewModels = viewModels
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: TableCell.identifier) as! TableCell
        cell.viewModel = viewModels[indexPath.row]
        cell.accessoryType = cell is DisclosableCell ? .disclosureIndicator : .none
        cell.selectionStyle = .none
        return cell
    }

}
