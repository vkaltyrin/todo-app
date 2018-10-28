import UIKit

class ListCell: UITableViewCell {

    @IBOutlet weak var textField: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()

        textField.delegate = self
    }

}

extension ListCell: UITextFieldDelegate {

}
