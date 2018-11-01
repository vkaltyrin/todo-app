import Foundation

final class ListTableBuilder: TableBuilder {

    typealias OnDeleteTap = ((_ identifier: Identifier) -> ())
    typealias OnListTap = ((ListViewModel) -> ())
    typealias OnCellTextDidEndEditing = ((ListViewModel) -> ())

    private let items: [ListViewModel]
    private let focusIdentifier: Identifier?
    private let onDeleteTap: OnDeleteTap?
    private let onListTap: OnListTap?
    private let onCellTextDidEndEditing: OnCellTextDidEndEditing?

    init(items: [ListViewModel],
         focusIdentifier: Identifier?,
         onDeleteTap: OnDeleteTap?,
         onListTap: OnListTap?,
         onCellTextDidEndEditing: OnCellTextDidEndEditing?) {
        self.items = items
        self.focusIdentifier = focusIdentifier
        self.onDeleteTap = onDeleteTap
        self.onListTap = onListTap
        self.onCellTextDidEndEditing = onCellTextDidEndEditing
    }

    func build() -> [TableSection] {
        var cells = [TableCell<ListCell>]()
        for viewModel in items {
            let cell = TableCell<ListCell>(viewModel: viewModel)
                .on(.tap) { [onListTap] parameters in onListTap?(parameters.viewModel) }
                .on(.swipeToDelete) { [onDeleteTap] parameters in onDeleteTap?(parameters.viewModel.identifier) }
                .on(.configure) { [onCellTextDidEndEditing] parameters in
                    let viewModel = parameters.viewModel
                    parameters.cell?.onTextDidEndEditing = { name in
                        onCellTextDidEndEditing?(
                            ListViewModel(identifier: viewModel.identifier, name: name)
                        )
                    }
                    parameters.cell?.setAccessibilityIdentifierIndex(
                        index: parameters.indexPath.row
                    )
                }
                .on(.willDisplay) { [focusIdentifier] parameters in
                    if let focusIdentifier = focusIdentifier, parameters.viewModel.identifier == focusIdentifier {
                        parameters.cell?.focus()
                    }
                }
            cells.append(cell)
        }
        return [TableSection(cells: cells)]
    }
}
