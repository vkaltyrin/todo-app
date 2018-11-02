import Foundation

final class TaskTableBuilder: TableBuilder {

    typealias OnDeleteTap = ((_ identifier: Identifier) -> ())
    typealias OnTaskTap = ((TaskViewModel) -> ())
    typealias OnCellTextDidEndEditing = ((TaskViewModel) -> ())

    private let items: [TaskViewModel]
    private let focusIdentifier: Identifier?
    private let onDeleteTap: OnDeleteTap?
    private let onTaskTap: OnTaskTap?
    private let onCellTextDidEndEditing: OnCellTextDidEndEditing?

    init(items: [TaskViewModel],
         focusIdentifier: Identifier?,
         onDeleteTap: OnDeleteTap?,
         onTaskTap: OnTaskTap?,
         onCellTextDidEndEditing: OnCellTextDidEndEditing?) {
        self.items = items
        self.focusIdentifier = focusIdentifier
        self.onDeleteTap = onDeleteTap
        self.onTaskTap = onTaskTap
        self.onCellTextDidEndEditing = onCellTextDidEndEditing
    }

    func build() -> [TableSection] {
        var cells = [TableCell<TaskCell>]()
        for viewModel in items {
            let cell = TableCell<TaskCell>(viewModel: viewModel)
                .on(.tap) { [onTaskTap] parameters in onTaskTap?(parameters.viewModel) }
                .on(.swipeToDelete) { [onDeleteTap] parameters in onDeleteTap?(parameters.viewModel.identifier) }
                .on(.configure) { [onCellTextDidEndEditing] parameters in
                    let viewModel = parameters.viewModel
                    parameters.cell?.onTextDidEndEditing = { name in
                        onCellTextDidEndEditing?(
                            TaskViewModel(identifier: viewModel.identifier, name: name)
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
