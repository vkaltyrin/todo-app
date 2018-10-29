import UIKit

class TaskCell: UITableViewCell {

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

}

extension TaskCell: ConfigurableCell {
    typealias ViewModel = TaskViewModel

    func configure(_ viewModel: TaskViewModel) {
        textField.text = viewModel.name
    }
}

extension TaskCell: UITextFieldDelegate {

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
