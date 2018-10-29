import UIKit

class ListCell: UITableViewCell {

    var onTextDidEndEditing: ((String) -> ())?
    var onTextWillBeginEditing: (() -> ())?

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

    func focus() {
        textField.isUserInteractionEnabled = true
        textField.becomeFirstResponder()
    }

    func disableFocus() {
        textField.isUserInteractionEnabled = false
    }

    override func resignFirstResponder() -> Bool {

        return super.resignFirstResponder()
    }
}

extension ListCell: ConfigurableCell {
    typealias ViewModel = ListViewModel

    func configure(_ viewModel: ListViewModel) {
        textField.text = viewModel.name
    }
}

extension ListCell: UITextFieldDelegate {

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
