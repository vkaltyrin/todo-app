import UIKit

class BaseCell: UITableViewCell {

    var onTextDidEndEditing: ((String) -> ())?

    @IBOutlet weak var textField: UITextField!

    override func prepareForReuse() {
        super.prepareForReuse()

        textField.isUserInteractionEnabled = false
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        textField.delegate = self
        textField.returnKeyType = .done
        textField.isUserInteractionEnabled = false
        self.selectionStyle = .none
    }

    func disableFocus() {
        textField.isUserInteractionEnabled = false
    }
}

extension BaseCell: CellFocusable {
    func focus() {
        textField.isUserInteractionEnabled = true
        textField.becomeFirstResponder()
    }
}

extension BaseCell: UITextFieldDelegate {

    func textFieldDidEndEditing(_ textField: UITextField) {
        disableFocus()
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        onTextDidEndEditing?(textField.text ?? "")
        return textField.resignFirstResponder()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        onTextDidEndEditing?(textField.text ?? "")
        return textField.resignFirstResponder()
    }

}
