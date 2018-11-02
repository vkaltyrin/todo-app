import Foundation

final class TaskTableBuilder: TableBuilder {

    typealias OnDeleteTap = ((_ identifier: Identifier) -> ())
    typealias OnTaskTap = ((TaskViewModel) -> ())

    private let items: [TaskViewModel]
    private let focusIdentifier: Identifier?
    private let onDeleteTap: OnDeleteTap?
    private let onTaskTap: OnTaskTap?

    init(items: [TaskViewModel],
         focusIdentifier: Identifier?,
         onDeleteTap: OnDeleteTap?,
         onTaskTap: OnTaskTap?) {
        self.items = items
        self.focusIdentifier = focusIdentifier
        self.onDeleteTap = onDeleteTap
        self.onTaskTap = onTaskTap
    }

    func build() -> [TableSection] {
        var cells = [TableCell<TaskCell>]()
        for viewModel in items {
            let cell = TableCell<TaskCell>(viewModel: viewModel)
                .on(.tap) { [onTaskTap] parameters in onTaskTap?(parameters.viewModel) }
                .on(.swipeToDelete) { [onDeleteTap] parameters in onDeleteTap?(parameters.viewModel.identifier) }
                .on(.configure) { parameters in
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
