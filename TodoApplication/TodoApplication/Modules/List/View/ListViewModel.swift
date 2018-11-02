import Foundation

struct ListViewModel {
    let identifier: Identifier
    let name: String
    let onTextDidEndEditing: ((_ newText: String) -> ())?
}
