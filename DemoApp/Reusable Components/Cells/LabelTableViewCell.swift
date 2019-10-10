
import UIKit

final class LabelTableViewCell: UITableViewCell, Cell, DisclosableCell {

    var viewModel: String! {
        didSet {
            label.text = viewModel
        }
    }

    @IBOutlet private weak var label: UILabel!

    // MARK: - Reuse

    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }

}
