import UIKit

class ListCell: UITableViewCell {

    var onTextDidEndEditing: ((String) -> ())?
    var onTextWillBeginEditing: (() -> ())?

    @IBOutlet weak var textField: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()

        textField.delegate = self
        textField.returnKeyType = .done
        textField.isUserInteractionEnabled = false
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}

extension ListCell: ConfigurableCell {
    typealias ViewModel = ListViewModel

    func configure(_ viewModel: ListViewModel) {
        textField.text = viewModel.name
    }
}

extension ListCell: UITextFieldDelegate {

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        onTextDidEndEditing?(textField.text ?? "")
        return textField.resignFirstResponder()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        onTextDidEndEditing?(textField.text ?? "")
        return textField.resignFirstResponder()
    }

}
