@testable import TodoApplication
import XCTest

final class ListViewTableDirectorMock: NSObject, ListViewTableDirector {

    var invokedItemsSetter = false
    var invokedItemsSetterCount = 0
    var invokedItems: [ListViewModel]?
    var invokedItemsList = [[ListViewModel]]()
    var invokedItemsGetter = false
    var invokedItemsGetterCount = 0
    var stubbedItems: [ListViewModel]! = []
    var items: [ListViewModel] {
        set {
            invokedItemsSetter = true
            invokedItemsSetterCount += 1
            invokedItems = newValue
            invokedItemsList.append(newValue)
        }
        get {
            invokedItemsGetter = true
            invokedItemsGetterCount += 1
            return stubbedItems
        }
    }
    var invokedOnListTapSetter = false
    var invokedOnListTapSetterCount = 0
    var invokedOnListTap: ((Identifier) -> ())?
    var invokedOnListTapList = [((Identifier) -> ())?]()
    var invokedOnListTapGetter = false
    var invokedOnListTapGetterCount = 0
    var stubbedOnListTap: ((Identifier) -> ())!
    var onListTap: ((Identifier) -> ())? {
        set {
            invokedOnListTapSetter = true
            invokedOnListTapSetterCount += 1
            invokedOnListTap = newValue
            invokedOnListTapList.append(newValue)
        }
        get {
            invokedOnListTapGetter = true
            invokedOnListTapGetterCount += 1
            return stubbedOnListTap
        }
    }
    var invokedOnCellTextDidEndEditingSetter = false
    var invokedOnCellTextDidEndEditingSetterCount = 0
    var invokedOnCellTextDidEndEditing: ((Identifier, String) -> ())?
    var invokedOnCellTextDidEndEditingList = [((Identifier, String) -> ())?]()
    var invokedOnCellTextDidEndEditingGetter = false
    var invokedOnCellTextDidEndEditingGetterCount = 0
    var stubbedOnCellTextDidEndEditing: ((Identifier, String) -> ())!
    var onCellTextDidEndEditing: ((Identifier, String) -> ())? {
        set {
            invokedOnCellTextDidEndEditingSetter = true
            invokedOnCellTextDidEndEditingSetterCount += 1
            invokedOnCellTextDidEndEditing = newValue
            invokedOnCellTextDidEndEditingList.append(newValue)
        }
        get {
            invokedOnCellTextDidEndEditingGetter = true
            invokedOnCellTextDidEndEditingGetterCount += 1
            return stubbedOnCellTextDidEndEditing
        }
    }
    var invokedOnDeleteTapSetter = false
    var invokedOnDeleteTapSetterCount = 0
    var invokedOnDeleteTap: ((Identifier) -> ())?
    var invokedOnDeleteTapList = [((Identifier) -> ())?]()
    var invokedOnDeleteTapGetter = false
    var invokedOnDeleteTapGetterCount = 0
    var stubbedOnDeleteTap: ((Identifier) -> ())!
    var onDeleteTap: ((Identifier) -> ())? {
        set {
            invokedOnDeleteTapSetter = true
            invokedOnDeleteTapSetterCount += 1
            invokedOnDeleteTap = newValue
            invokedOnDeleteTapList.append(newValue)
        }
        get {
            invokedOnDeleteTapGetter = true
            invokedOnDeleteTapGetterCount += 1
            return stubbedOnDeleteTap
        }
    }
    var invokedFocusOnList = false
    var invokedFocusOnListCount = 0
    var invokedFocusOnListParameters: (identifier: Identifier, Void)?
    var invokedFocusOnListParametersList = [(identifier: Identifier, Void)]()

    func focusOnList(_ identifier: Identifier) {
        invokedFocusOnList = true
        invokedFocusOnListCount += 1
        invokedFocusOnListParameters = (identifier, ())
        invokedFocusOnListParametersList.append((identifier, ()))
    }

    var invokedSetup = false
    var invokedSetupCount = 0
    var invokedSetupParameters: (tableView: UITableView, Void)?
    var invokedSetupParametersList = [(tableView: UITableView, Void)]()

    func setup(with tableView: UITableView) {
        invokedSetup = true
        invokedSetupCount += 1
        invokedSetupParameters = (tableView, ())
        invokedSetupParametersList.append((tableView, ()))
    }

    var invokedReload = false
    var invokedReloadCount = 0

    func reload() {
        invokedReload = true
        invokedReloadCount += 1
    }

    var invokedTableViewWillDisplay = false
    var invokedTableViewWillDisplayCount = 0
    var invokedTableViewWillDisplayParameters: (tableView: UITableView, cell: UITableViewCell, indexPath: IndexPath)?
    var invokedTableViewWillDisplayParametersList = [(tableView: UITableView, cell: UITableViewCell, indexPath: IndexPath)]()

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        invokedTableViewWillDisplay = true
        invokedTableViewWillDisplayCount += 1
        invokedTableViewWillDisplayParameters = (tableView, cell, indexPath)
        invokedTableViewWillDisplayParametersList.append((tableView, cell, indexPath))
    }

    var invokedTableViewWillDisplayHeaderView = false
    var invokedTableViewWillDisplayHeaderViewCount = 0
    var invokedTableViewWillDisplayHeaderViewParameters: (tableView: UITableView, view: UIView, section: Int)?
    var invokedTableViewWillDisplayHeaderViewParametersList = [(tableView: UITableView, view: UIView, section: Int)]()

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        invokedTableViewWillDisplayHeaderView = true
        invokedTableViewWillDisplayHeaderViewCount += 1
        invokedTableViewWillDisplayHeaderViewParameters = (tableView, view, section)
        invokedTableViewWillDisplayHeaderViewParametersList.append((tableView, view, section))
    }

    var invokedTableViewWillDisplayFooterView = false
    var invokedTableViewWillDisplayFooterViewCount = 0
    var invokedTableViewWillDisplayFooterViewParameters: (tableView: UITableView, view: UIView, section: Int)?
    var invokedTableViewWillDisplayFooterViewParametersList = [(tableView: UITableView, view: UIView, section: Int)]()

    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        invokedTableViewWillDisplayFooterView = true
        invokedTableViewWillDisplayFooterViewCount += 1
        invokedTableViewWillDisplayFooterViewParameters = (tableView, view, section)
        invokedTableViewWillDisplayFooterViewParametersList.append((tableView, view, section))
    }

    var invokedTableViewDidEndDisplaying = false
    var invokedTableViewDidEndDisplayingCount = 0
    var invokedTableViewDidEndDisplayingParameters: (tableView: UITableView, cell: UITableViewCell, indexPath: IndexPath)?
    var invokedTableViewDidEndDisplayingParametersList = [(tableView: UITableView, cell: UITableViewCell, indexPath: IndexPath)]()

    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        invokedTableViewDidEndDisplaying = true
        invokedTableViewDidEndDisplayingCount += 1
        invokedTableViewDidEndDisplayingParameters = (tableView, cell, indexPath)
        invokedTableViewDidEndDisplayingParametersList.append((tableView, cell, indexPath))
    }

    var invokedTableViewDidEndDisplayingHeaderView = false
    var invokedTableViewDidEndDisplayingHeaderViewCount = 0
    var invokedTableViewDidEndDisplayingHeaderViewParameters: (tableView: UITableView, view: UIView, section: Int)?
    var invokedTableViewDidEndDisplayingHeaderViewParametersList = [(tableView: UITableView, view: UIView, section: Int)]()

    func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        invokedTableViewDidEndDisplayingHeaderView = true
        invokedTableViewDidEndDisplayingHeaderViewCount += 1
        invokedTableViewDidEndDisplayingHeaderViewParameters = (tableView, view, section)
        invokedTableViewDidEndDisplayingHeaderViewParametersList.append((tableView, view, section))
    }

    var invokedTableViewDidEndDisplayingFooterView = false
    var invokedTableViewDidEndDisplayingFooterViewCount = 0
    var invokedTableViewDidEndDisplayingFooterViewParameters: (tableView: UITableView, view: UIView, section: Int)?
    var invokedTableViewDidEndDisplayingFooterViewParametersList = [(tableView: UITableView, view: UIView, section: Int)]()

    func tableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int) {
        invokedTableViewDidEndDisplayingFooterView = true
        invokedTableViewDidEndDisplayingFooterViewCount += 1
        invokedTableViewDidEndDisplayingFooterViewParameters = (tableView, view, section)
        invokedTableViewDidEndDisplayingFooterViewParametersList.append((tableView, view, section))
    }

    var invokedTableViewHeightForRowAt = false
    var invokedTableViewHeightForRowAtCount = 0
    var invokedTableViewHeightForRowAtParameters: (tableView: UITableView, indexPath: IndexPath)?
    var invokedTableViewHeightForRowAtParametersList = [(tableView: UITableView, indexPath: IndexPath)]()
    var stubbedTableViewHeightForRowAtResult: CGFloat!

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        invokedTableViewHeightForRowAt = true
        invokedTableViewHeightForRowAtCount += 1
        invokedTableViewHeightForRowAtParameters = (tableView, indexPath)
        invokedTableViewHeightForRowAtParametersList.append((tableView, indexPath))
        return stubbedTableViewHeightForRowAtResult
    }

    var invokedTableViewHeightForHeaderInSection = false
    var invokedTableViewHeightForHeaderInSectionCount = 0
    var invokedTableViewHeightForHeaderInSectionParameters: (tableView: UITableView, section: Int)?
    var invokedTableViewHeightForHeaderInSectionParametersList = [(tableView: UITableView, section: Int)]()
    var stubbedTableViewHeightForHeaderInSectionResult: CGFloat!

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        invokedTableViewHeightForHeaderInSection = true
        invokedTableViewHeightForHeaderInSectionCount += 1
        invokedTableViewHeightForHeaderInSectionParameters = (tableView, section)
        invokedTableViewHeightForHeaderInSectionParametersList.append((tableView, section))
        return stubbedTableViewHeightForHeaderInSectionResult
    }

    var invokedTableViewHeightForFooterInSection = false
    var invokedTableViewHeightForFooterInSectionCount = 0
    var invokedTableViewHeightForFooterInSectionParameters: (tableView: UITableView, section: Int)?
    var invokedTableViewHeightForFooterInSectionParametersList = [(tableView: UITableView, section: Int)]()
    var stubbedTableViewHeightForFooterInSectionResult: CGFloat!

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        invokedTableViewHeightForFooterInSection = true
        invokedTableViewHeightForFooterInSectionCount += 1
        invokedTableViewHeightForFooterInSectionParameters = (tableView, section)
        invokedTableViewHeightForFooterInSectionParametersList.append((tableView, section))
        return stubbedTableViewHeightForFooterInSectionResult
    }

    var invokedTableViewEstimatedHeightForRowAt = false
    var invokedTableViewEstimatedHeightForRowAtCount = 0
    var invokedTableViewEstimatedHeightForRowAtParameters: (tableView: UITableView, indexPath: IndexPath)?
    var invokedTableViewEstimatedHeightForRowAtParametersList = [(tableView: UITableView, indexPath: IndexPath)]()
    var stubbedTableViewEstimatedHeightForRowAtResult: CGFloat!

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        invokedTableViewEstimatedHeightForRowAt = true
        invokedTableViewEstimatedHeightForRowAtCount += 1
        invokedTableViewEstimatedHeightForRowAtParameters = (tableView, indexPath)
        invokedTableViewEstimatedHeightForRowAtParametersList.append((tableView, indexPath))
        return stubbedTableViewEstimatedHeightForRowAtResult
    }

    var invokedTableViewEstimatedHeightForHeaderInSection = false
    var invokedTableViewEstimatedHeightForHeaderInSectionCount = 0
    var invokedTableViewEstimatedHeightForHeaderInSectionParameters: (tableView: UITableView, section: Int)?
    var invokedTableViewEstimatedHeightForHeaderInSectionParametersList = [(tableView: UITableView, section: Int)]()
    var stubbedTableViewEstimatedHeightForHeaderInSectionResult: CGFloat!

    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        invokedTableViewEstimatedHeightForHeaderInSection = true
        invokedTableViewEstimatedHeightForHeaderInSectionCount += 1
        invokedTableViewEstimatedHeightForHeaderInSectionParameters = (tableView, section)
        invokedTableViewEstimatedHeightForHeaderInSectionParametersList.append((tableView, section))
        return stubbedTableViewEstimatedHeightForHeaderInSectionResult
    }

    var invokedTableViewEstimatedHeightForFooterInSection = false
    var invokedTableViewEstimatedHeightForFooterInSectionCount = 0
    var invokedTableViewEstimatedHeightForFooterInSectionParameters: (tableView: UITableView, section: Int)?
    var invokedTableViewEstimatedHeightForFooterInSectionParametersList = [(tableView: UITableView, section: Int)]()
    var stubbedTableViewEstimatedHeightForFooterInSectionResult: CGFloat!

    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        invokedTableViewEstimatedHeightForFooterInSection = true
        invokedTableViewEstimatedHeightForFooterInSectionCount += 1
        invokedTableViewEstimatedHeightForFooterInSectionParameters = (tableView, section)
        invokedTableViewEstimatedHeightForFooterInSectionParametersList.append((tableView, section))
        return stubbedTableViewEstimatedHeightForFooterInSectionResult
    }

    var invokedTableViewViewForHeaderInSection = false
    var invokedTableViewViewForHeaderInSectionCount = 0
    var invokedTableViewViewForHeaderInSectionParameters: (tableView: UITableView, section: Int)?
    var invokedTableViewViewForHeaderInSectionParametersList = [(tableView: UITableView, section: Int)]()
    var stubbedTableViewViewForHeaderInSectionResult: UIView!

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        invokedTableViewViewForHeaderInSection = true
        invokedTableViewViewForHeaderInSectionCount += 1
        invokedTableViewViewForHeaderInSectionParameters = (tableView, section)
        invokedTableViewViewForHeaderInSectionParametersList.append((tableView, section))
        return stubbedTableViewViewForHeaderInSectionResult
    }

    var invokedTableViewViewForFooterInSection = false
    var invokedTableViewViewForFooterInSectionCount = 0
    var invokedTableViewViewForFooterInSectionParameters: (tableView: UITableView, section: Int)?
    var invokedTableViewViewForFooterInSectionParametersList = [(tableView: UITableView, section: Int)]()
    var stubbedTableViewViewForFooterInSectionResult: UIView!

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        invokedTableViewViewForFooterInSection = true
        invokedTableViewViewForFooterInSectionCount += 1
        invokedTableViewViewForFooterInSectionParameters = (tableView, section)
        invokedTableViewViewForFooterInSectionParametersList.append((tableView, section))
        return stubbedTableViewViewForFooterInSectionResult
    }

    var invokedTableViewAccessoryButtonTappedForRowWith = false
    var invokedTableViewAccessoryButtonTappedForRowWithCount = 0
    var invokedTableViewAccessoryButtonTappedForRowWithParameters: (tableView: UITableView, indexPath: IndexPath)?
    var invokedTableViewAccessoryButtonTappedForRowWithParametersList = [(tableView: UITableView, indexPath: IndexPath)]()

    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        invokedTableViewAccessoryButtonTappedForRowWith = true
        invokedTableViewAccessoryButtonTappedForRowWithCount += 1
        invokedTableViewAccessoryButtonTappedForRowWithParameters = (tableView, indexPath)
        invokedTableViewAccessoryButtonTappedForRowWithParametersList.append((tableView, indexPath))
    }

    var invokedTableViewShouldHighlightRowAt = false
    var invokedTableViewShouldHighlightRowAtCount = 0
    var invokedTableViewShouldHighlightRowAtParameters: (tableView: UITableView, indexPath: IndexPath)?
    var invokedTableViewShouldHighlightRowAtParametersList = [(tableView: UITableView, indexPath: IndexPath)]()
    var stubbedTableViewShouldHighlightRowAtResult: Bool! = false

    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        invokedTableViewShouldHighlightRowAt = true
        invokedTableViewShouldHighlightRowAtCount += 1
        invokedTableViewShouldHighlightRowAtParameters = (tableView, indexPath)
        invokedTableViewShouldHighlightRowAtParametersList.append((tableView, indexPath))
        return stubbedTableViewShouldHighlightRowAtResult
    }

    var invokedTableViewDidHighlightRowAt = false
    var invokedTableViewDidHighlightRowAtCount = 0
    var invokedTableViewDidHighlightRowAtParameters: (tableView: UITableView, indexPath: IndexPath)?
    var invokedTableViewDidHighlightRowAtParametersList = [(tableView: UITableView, indexPath: IndexPath)]()

    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        invokedTableViewDidHighlightRowAt = true
        invokedTableViewDidHighlightRowAtCount += 1
        invokedTableViewDidHighlightRowAtParameters = (tableView, indexPath)
        invokedTableViewDidHighlightRowAtParametersList.append((tableView, indexPath))
    }

    var invokedTableViewDidUnhighlightRowAt = false
    var invokedTableViewDidUnhighlightRowAtCount = 0
    var invokedTableViewDidUnhighlightRowAtParameters: (tableView: UITableView, indexPath: IndexPath)?
    var invokedTableViewDidUnhighlightRowAtParametersList = [(tableView: UITableView, indexPath: IndexPath)]()

    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        invokedTableViewDidUnhighlightRowAt = true
        invokedTableViewDidUnhighlightRowAtCount += 1
        invokedTableViewDidUnhighlightRowAtParameters = (tableView, indexPath)
        invokedTableViewDidUnhighlightRowAtParametersList.append((tableView, indexPath))
    }

    var invokedTableViewWillSelectRowAt = false
    var invokedTableViewWillSelectRowAtCount = 0
    var invokedTableViewWillSelectRowAtParameters: (tableView: UITableView, indexPath: IndexPath)?
    var invokedTableViewWillSelectRowAtParametersList = [(tableView: UITableView, indexPath: IndexPath)]()
    var stubbedTableViewWillSelectRowAtResult: IndexPath!

    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        invokedTableViewWillSelectRowAt = true
        invokedTableViewWillSelectRowAtCount += 1
        invokedTableViewWillSelectRowAtParameters = (tableView, indexPath)
        invokedTableViewWillSelectRowAtParametersList.append((tableView, indexPath))
        return stubbedTableViewWillSelectRowAtResult
    }

    var invokedTableViewWillDeselectRowAt = false
    var invokedTableViewWillDeselectRowAtCount = 0
    var invokedTableViewWillDeselectRowAtParameters: (tableView: UITableView, indexPath: IndexPath)?
    var invokedTableViewWillDeselectRowAtParametersList = [(tableView: UITableView, indexPath: IndexPath)]()
    var stubbedTableViewWillDeselectRowAtResult: IndexPath!

    func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        invokedTableViewWillDeselectRowAt = true
        invokedTableViewWillDeselectRowAtCount += 1
        invokedTableViewWillDeselectRowAtParameters = (tableView, indexPath)
        invokedTableViewWillDeselectRowAtParametersList.append((tableView, indexPath))
        return stubbedTableViewWillDeselectRowAtResult
    }

    var invokedTableViewDidSelectRowAt = false
    var invokedTableViewDidSelectRowAtCount = 0
    var invokedTableViewDidSelectRowAtParameters: (tableView: UITableView, indexPath: IndexPath)?
    var invokedTableViewDidSelectRowAtParametersList = [(tableView: UITableView, indexPath: IndexPath)]()

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        invokedTableViewDidSelectRowAt = true
        invokedTableViewDidSelectRowAtCount += 1
        invokedTableViewDidSelectRowAtParameters = (tableView, indexPath)
        invokedTableViewDidSelectRowAtParametersList.append((tableView, indexPath))
    }

    var invokedTableViewDidDeselectRowAt = false
    var invokedTableViewDidDeselectRowAtCount = 0
    var invokedTableViewDidDeselectRowAtParameters: (tableView: UITableView, indexPath: IndexPath)?
    var invokedTableViewDidDeselectRowAtParametersList = [(tableView: UITableView, indexPath: IndexPath)]()

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        invokedTableViewDidDeselectRowAt = true
        invokedTableViewDidDeselectRowAtCount += 1
        invokedTableViewDidDeselectRowAtParameters = (tableView, indexPath)
        invokedTableViewDidDeselectRowAtParametersList.append((tableView, indexPath))
    }

    var invokedTableViewEditingStyleForRowAt = false
    var invokedTableViewEditingStyleForRowAtCount = 0
    var invokedTableViewEditingStyleForRowAtParameters: (tableView: UITableView, indexPath: IndexPath)?
    var invokedTableViewEditingStyleForRowAtParametersList = [(tableView: UITableView, indexPath: IndexPath)]()
    var stubbedTableViewEditingStyleForRowAtResult: UITableViewCell.EditingStyle!

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        invokedTableViewEditingStyleForRowAt = true
        invokedTableViewEditingStyleForRowAtCount += 1
        invokedTableViewEditingStyleForRowAtParameters = (tableView, indexPath)
        invokedTableViewEditingStyleForRowAtParametersList.append((tableView, indexPath))
        return stubbedTableViewEditingStyleForRowAtResult
    }

    var invokedTableViewTitleForDeleteConfirmationButtonForRowAt = false
    var invokedTableViewTitleForDeleteConfirmationButtonForRowAtCount = 0
    var invokedTableViewTitleForDeleteConfirmationButtonForRowAtParameters: (tableView: UITableView, indexPath: IndexPath)?
    var invokedTableViewTitleForDeleteConfirmationButtonForRowAtParametersList = [(tableView: UITableView, indexPath: IndexPath)]()
    var stubbedTableViewTitleForDeleteConfirmationButtonForRowAtResult: String!

    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        invokedTableViewTitleForDeleteConfirmationButtonForRowAt = true
        invokedTableViewTitleForDeleteConfirmationButtonForRowAtCount += 1
        invokedTableViewTitleForDeleteConfirmationButtonForRowAtParameters = (tableView, indexPath)
        invokedTableViewTitleForDeleteConfirmationButtonForRowAtParametersList.append((tableView, indexPath))
        return stubbedTableViewTitleForDeleteConfirmationButtonForRowAtResult
    }

    var invokedTableViewEditActionsForRowAt = false
    var invokedTableViewEditActionsForRowAtCount = 0
    var invokedTableViewEditActionsForRowAtParameters: (tableView: UITableView, indexPath: IndexPath)?
    var invokedTableViewEditActionsForRowAtParametersList = [(tableView: UITableView, indexPath: IndexPath)]()
    var stubbedTableViewEditActionsForRowAtResult: [UITableViewRowAction]!

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        invokedTableViewEditActionsForRowAt = true
        invokedTableViewEditActionsForRowAtCount += 1
        invokedTableViewEditActionsForRowAtParameters = (tableView, indexPath)
        invokedTableViewEditActionsForRowAtParametersList.append((tableView, indexPath))
        return stubbedTableViewEditActionsForRowAtResult
    }

    var invokedTableViewLeadingSwipeActionsConfigurationForRowAt = false
    var invokedTableViewLeadingSwipeActionsConfigurationForRowAtCount = 0
    var invokedTableViewLeadingSwipeActionsConfigurationForRowAtParameters: (tableView: UITableView, indexPath: IndexPath)?
    var invokedTableViewLeadingSwipeActionsConfigurationForRowAtParametersList = [(tableView: UITableView, indexPath: IndexPath)]()
    var stubbedTableViewLeadingSwipeActionsConfigurationForRowAtResult: UISwipeActionsConfiguration!

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        invokedTableViewLeadingSwipeActionsConfigurationForRowAt = true
        invokedTableViewLeadingSwipeActionsConfigurationForRowAtCount += 1
        invokedTableViewLeadingSwipeActionsConfigurationForRowAtParameters = (tableView, indexPath)
        invokedTableViewLeadingSwipeActionsConfigurationForRowAtParametersList.append((tableView, indexPath))
        return stubbedTableViewLeadingSwipeActionsConfigurationForRowAtResult
    }

    var invokedTableViewTrailingSwipeActionsConfigurationForRowAt = false
    var invokedTableViewTrailingSwipeActionsConfigurationForRowAtCount = 0
    var invokedTableViewTrailingSwipeActionsConfigurationForRowAtParameters: (tableView: UITableView, indexPath: IndexPath)?
    var invokedTableViewTrailingSwipeActionsConfigurationForRowAtParametersList = [(tableView: UITableView, indexPath: IndexPath)]()
    var stubbedTableViewTrailingSwipeActionsConfigurationForRowAtResult: UISwipeActionsConfiguration!

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        invokedTableViewTrailingSwipeActionsConfigurationForRowAt = true
        invokedTableViewTrailingSwipeActionsConfigurationForRowAtCount += 1
        invokedTableViewTrailingSwipeActionsConfigurationForRowAtParameters = (tableView, indexPath)
        invokedTableViewTrailingSwipeActionsConfigurationForRowAtParametersList.append((tableView, indexPath))
        return stubbedTableViewTrailingSwipeActionsConfigurationForRowAtResult
    }

    var invokedTableViewShouldIndentWhileEditingRowAt = false
    var invokedTableViewShouldIndentWhileEditingRowAtCount = 0
    var invokedTableViewShouldIndentWhileEditingRowAtParameters: (tableView: UITableView, indexPath: IndexPath)?
    var invokedTableViewShouldIndentWhileEditingRowAtParametersList = [(tableView: UITableView, indexPath: IndexPath)]()
    var stubbedTableViewShouldIndentWhileEditingRowAtResult: Bool! = false

    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        invokedTableViewShouldIndentWhileEditingRowAt = true
        invokedTableViewShouldIndentWhileEditingRowAtCount += 1
        invokedTableViewShouldIndentWhileEditingRowAtParameters = (tableView, indexPath)
        invokedTableViewShouldIndentWhileEditingRowAtParametersList.append((tableView, indexPath))
        return stubbedTableViewShouldIndentWhileEditingRowAtResult
    }

    var invokedTableViewWillBeginEditingRowAt = false
    var invokedTableViewWillBeginEditingRowAtCount = 0
    var invokedTableViewWillBeginEditingRowAtParameters: (tableView: UITableView, indexPath: IndexPath)?
    var invokedTableViewWillBeginEditingRowAtParametersList = [(tableView: UITableView, indexPath: IndexPath)]()

    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        invokedTableViewWillBeginEditingRowAt = true
        invokedTableViewWillBeginEditingRowAtCount += 1
        invokedTableViewWillBeginEditingRowAtParameters = (tableView, indexPath)
        invokedTableViewWillBeginEditingRowAtParametersList.append((tableView, indexPath))
    }

    var invokedTableViewDidEndEditingRowAt = false
    var invokedTableViewDidEndEditingRowAtCount = 0
    var invokedTableViewDidEndEditingRowAtParameters: (tableView: UITableView, indexPath: IndexPath?)?
    var invokedTableViewDidEndEditingRowAtParametersList = [(tableView: UITableView, indexPath: IndexPath?)]()

    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        invokedTableViewDidEndEditingRowAt = true
        invokedTableViewDidEndEditingRowAtCount += 1
        invokedTableViewDidEndEditingRowAtParameters = (tableView, indexPath)
        invokedTableViewDidEndEditingRowAtParametersList.append((tableView, indexPath))
    }

    var invokedTableViewTargetIndexPathForMoveFromRowAt = false
    var invokedTableViewTargetIndexPathForMoveFromRowAtCount = 0
    var invokedTableViewTargetIndexPathForMoveFromRowAtParameters: (tableView: UITableView, sourceIndexPath: IndexPath, proposedDestinationIndexPath: IndexPath)?
    var invokedTableViewTargetIndexPathForMoveFromRowAtParametersList = [(tableView: UITableView, sourceIndexPath: IndexPath, proposedDestinationIndexPath: IndexPath)]()
    var stubbedTableViewTargetIndexPathForMoveFromRowAtResult: IndexPath!

    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        invokedTableViewTargetIndexPathForMoveFromRowAt = true
        invokedTableViewTargetIndexPathForMoveFromRowAtCount += 1
        invokedTableViewTargetIndexPathForMoveFromRowAtParameters = (tableView, sourceIndexPath, proposedDestinationIndexPath)
        invokedTableViewTargetIndexPathForMoveFromRowAtParametersList.append((tableView, sourceIndexPath, proposedDestinationIndexPath))
        return stubbedTableViewTargetIndexPathForMoveFromRowAtResult
    }

    var invokedTableViewIndentationLevelForRowAt = false
    var invokedTableViewIndentationLevelForRowAtCount = 0
    var invokedTableViewIndentationLevelForRowAtParameters: (tableView: UITableView, indexPath: IndexPath)?
    var invokedTableViewIndentationLevelForRowAtParametersList = [(tableView: UITableView, indexPath: IndexPath)]()
    var stubbedTableViewIndentationLevelForRowAtResult: Int! = 0

    func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        invokedTableViewIndentationLevelForRowAt = true
        invokedTableViewIndentationLevelForRowAtCount += 1
        invokedTableViewIndentationLevelForRowAtParameters = (tableView, indexPath)
        invokedTableViewIndentationLevelForRowAtParametersList.append((tableView, indexPath))
        return stubbedTableViewIndentationLevelForRowAtResult
    }

    var invokedTableViewShouldShowMenuForRowAt = false
    var invokedTableViewShouldShowMenuForRowAtCount = 0
    var invokedTableViewShouldShowMenuForRowAtParameters: (tableView: UITableView, indexPath: IndexPath)?
    var invokedTableViewShouldShowMenuForRowAtParametersList = [(tableView: UITableView, indexPath: IndexPath)]()
    var stubbedTableViewShouldShowMenuForRowAtResult: Bool! = false

    func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool {
        invokedTableViewShouldShowMenuForRowAt = true
        invokedTableViewShouldShowMenuForRowAtCount += 1
        invokedTableViewShouldShowMenuForRowAtParameters = (tableView, indexPath)
        invokedTableViewShouldShowMenuForRowAtParametersList.append((tableView, indexPath))
        return stubbedTableViewShouldShowMenuForRowAtResult
    }

    var invokedTableViewCanPerformAction = false
    var invokedTableViewCanPerformActionCount = 0
    var invokedTableViewCanPerformActionParameters: (tableView: UITableView, action: Selector, indexPath: IndexPath, sender: Any?)?
    var invokedTableViewCanPerformActionParametersList = [(tableView: UITableView, action: Selector, indexPath: IndexPath, sender: Any?)]()
    var stubbedTableViewCanPerformActionResult: Bool! = false

    func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        invokedTableViewCanPerformAction = true
        invokedTableViewCanPerformActionCount += 1
        invokedTableViewCanPerformActionParameters = (tableView, action, indexPath, sender)
        invokedTableViewCanPerformActionParametersList.append((tableView, action, indexPath, sender))
        return stubbedTableViewCanPerformActionResult
    }

    var invokedTableViewPerformAction = false
    var invokedTableViewPerformActionCount = 0
    var invokedTableViewPerformActionParameters: (tableView: UITableView, action: Selector, indexPath: IndexPath, sender: Any?)?
    var invokedTableViewPerformActionParametersList = [(tableView: UITableView, action: Selector, indexPath: IndexPath, sender: Any?)]()

    func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) {
        invokedTableViewPerformAction = true
        invokedTableViewPerformActionCount += 1
        invokedTableViewPerformActionParameters = (tableView, action, indexPath, sender)
        invokedTableViewPerformActionParametersList.append((tableView, action, indexPath, sender))
    }

    var invokedTableViewCanFocusRowAt = false
    var invokedTableViewCanFocusRowAtCount = 0
    var invokedTableViewCanFocusRowAtParameters: (tableView: UITableView, indexPath: IndexPath)?
    var invokedTableViewCanFocusRowAtParametersList = [(tableView: UITableView, indexPath: IndexPath)]()
    var stubbedTableViewCanFocusRowAtResult: Bool! = false

    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        invokedTableViewCanFocusRowAt = true
        invokedTableViewCanFocusRowAtCount += 1
        invokedTableViewCanFocusRowAtParameters = (tableView, indexPath)
        invokedTableViewCanFocusRowAtParametersList.append((tableView, indexPath))
        return stubbedTableViewCanFocusRowAtResult
    }

    var invokedTableViewShouldUpdateFocusIn = false
    var invokedTableViewShouldUpdateFocusInCount = 0
    var invokedTableViewShouldUpdateFocusInParameters: (tableView: UITableView, context: UITableViewFocusUpdateContext)?
    var invokedTableViewShouldUpdateFocusInParametersList = [(tableView: UITableView, context: UITableViewFocusUpdateContext)]()
    var stubbedTableViewShouldUpdateFocusInResult: Bool! = false

    func tableView(_ tableView: UITableView, shouldUpdateFocusIn context: UITableViewFocusUpdateContext) -> Bool {
        invokedTableViewShouldUpdateFocusIn = true
        invokedTableViewShouldUpdateFocusInCount += 1
        invokedTableViewShouldUpdateFocusInParameters = (tableView, context)
        invokedTableViewShouldUpdateFocusInParametersList.append((tableView, context))
        return stubbedTableViewShouldUpdateFocusInResult
    }

    var invokedTableViewDidUpdateFocusIn = false
    var invokedTableViewDidUpdateFocusInCount = 0
    var invokedTableViewDidUpdateFocusInParameters: (tableView: UITableView, context: UITableViewFocusUpdateContext, coordinator: UIFocusAnimationCoordinator)?
    var invokedTableViewDidUpdateFocusInParametersList = [(tableView: UITableView, context: UITableViewFocusUpdateContext, coordinator: UIFocusAnimationCoordinator)]()

    func tableView(_ tableView: UITableView, didUpdateFocusIn context: UITableViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        invokedTableViewDidUpdateFocusIn = true
        invokedTableViewDidUpdateFocusInCount += 1
        invokedTableViewDidUpdateFocusInParameters = (tableView, context, coordinator)
        invokedTableViewDidUpdateFocusInParametersList.append((tableView, context, coordinator))
    }

    var invokedIndexPathForPreferredFocusedView = false
    var invokedIndexPathForPreferredFocusedViewCount = 0
    var invokedIndexPathForPreferredFocusedViewParameters: (tableView: UITableView, Void)?
    var invokedIndexPathForPreferredFocusedViewParametersList = [(tableView: UITableView, Void)]()
    var stubbedIndexPathForPreferredFocusedViewResult: IndexPath!

    func indexPathForPreferredFocusedView(in tableView: UITableView) -> IndexPath? {
        invokedIndexPathForPreferredFocusedView = true
        invokedIndexPathForPreferredFocusedViewCount += 1
        invokedIndexPathForPreferredFocusedViewParameters = (tableView, ())
        invokedIndexPathForPreferredFocusedViewParametersList.append((tableView, ()))
        return stubbedIndexPathForPreferredFocusedViewResult
    }

    var invokedTableViewShouldSpringLoadRowAt = false
    var invokedTableViewShouldSpringLoadRowAtCount = 0
    var invokedTableViewShouldSpringLoadRowAtParameters: (tableView: UITableView, indexPath: IndexPath, context: UISpringLoadedInteractionContext)?
    var invokedTableViewShouldSpringLoadRowAtParametersList = [(tableView: UITableView, indexPath: IndexPath, context: UISpringLoadedInteractionContext)]()
    var stubbedTableViewShouldSpringLoadRowAtResult: Bool! = false

    func tableView(_ tableView: UITableView, shouldSpringLoadRowAt indexPath: IndexPath, with context: UISpringLoadedInteractionContext) -> Bool {
        invokedTableViewShouldSpringLoadRowAt = true
        invokedTableViewShouldSpringLoadRowAtCount += 1
        invokedTableViewShouldSpringLoadRowAtParameters = (tableView, indexPath, context)
        invokedTableViewShouldSpringLoadRowAtParametersList.append((tableView, indexPath, context))
        return stubbedTableViewShouldSpringLoadRowAtResult
    }

    var invokedTableViewNumberOfRowsInSection = false
    var invokedTableViewNumberOfRowsInSectionCount = 0
    var invokedTableViewNumberOfRowsInSectionParameters: (tableView: UITableView, section: Int)?
    var invokedTableViewNumberOfRowsInSectionParametersList = [(tableView: UITableView, section: Int)]()
    var stubbedTableViewNumberOfRowsInSectionResult: Int! = 0

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        invokedTableViewNumberOfRowsInSection = true
        invokedTableViewNumberOfRowsInSectionCount += 1
        invokedTableViewNumberOfRowsInSectionParameters = (tableView, section)
        invokedTableViewNumberOfRowsInSectionParametersList.append((tableView, section))
        return stubbedTableViewNumberOfRowsInSectionResult
    }

    var invokedTableViewCellForRowAt = false
    var invokedTableViewCellForRowAtCount = 0
    var invokedTableViewCellForRowAtParameters: (tableView: UITableView, indexPath: IndexPath)?
    var invokedTableViewCellForRowAtParametersList = [(tableView: UITableView, indexPath: IndexPath)]()
    var stubbedTableViewCellForRowAtResult: UITableViewCell!

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        invokedTableViewCellForRowAt = true
        invokedTableViewCellForRowAtCount += 1
        invokedTableViewCellForRowAtParameters = (tableView, indexPath)
        invokedTableViewCellForRowAtParametersList.append((tableView, indexPath))
        return stubbedTableViewCellForRowAtResult
    }

    var invokedNumberOfSections = false
    var invokedNumberOfSectionsCount = 0
    var invokedNumberOfSectionsParameters: (tableView: UITableView, Void)?
    var invokedNumberOfSectionsParametersList = [(tableView: UITableView, Void)]()
    var stubbedNumberOfSectionsResult: Int! = 0

    func numberOfSections(in tableView: UITableView) -> Int {
        invokedNumberOfSections = true
        invokedNumberOfSectionsCount += 1
        invokedNumberOfSectionsParameters = (tableView, ())
        invokedNumberOfSectionsParametersList.append((tableView, ()))
        return stubbedNumberOfSectionsResult
    }

    var invokedTableViewTitleForHeaderInSection = false
    var invokedTableViewTitleForHeaderInSectionCount = 0
    var invokedTableViewTitleForHeaderInSectionParameters: (tableView: UITableView, section: Int)?
    var invokedTableViewTitleForHeaderInSectionParametersList = [(tableView: UITableView, section: Int)]()
    var stubbedTableViewTitleForHeaderInSectionResult: String!

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        invokedTableViewTitleForHeaderInSection = true
        invokedTableViewTitleForHeaderInSectionCount += 1
        invokedTableViewTitleForHeaderInSectionParameters = (tableView, section)
        invokedTableViewTitleForHeaderInSectionParametersList.append((tableView, section))
        return stubbedTableViewTitleForHeaderInSectionResult
    }

    var invokedTableViewTitleForFooterInSection = false
    var invokedTableViewTitleForFooterInSectionCount = 0
    var invokedTableViewTitleForFooterInSectionParameters: (tableView: UITableView, section: Int)?
    var invokedTableViewTitleForFooterInSectionParametersList = [(tableView: UITableView, section: Int)]()
    var stubbedTableViewTitleForFooterInSectionResult: String!

    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        invokedTableViewTitleForFooterInSection = true
        invokedTableViewTitleForFooterInSectionCount += 1
        invokedTableViewTitleForFooterInSectionParameters = (tableView, section)
        invokedTableViewTitleForFooterInSectionParametersList.append((tableView, section))
        return stubbedTableViewTitleForFooterInSectionResult
    }

    var invokedTableViewCanEditRowAt = false
    var invokedTableViewCanEditRowAtCount = 0
    var invokedTableViewCanEditRowAtParameters: (tableView: UITableView, indexPath: IndexPath)?
    var invokedTableViewCanEditRowAtParametersList = [(tableView: UITableView, indexPath: IndexPath)]()
    var stubbedTableViewCanEditRowAtResult: Bool! = false

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        invokedTableViewCanEditRowAt = true
        invokedTableViewCanEditRowAtCount += 1
        invokedTableViewCanEditRowAtParameters = (tableView, indexPath)
        invokedTableViewCanEditRowAtParametersList.append((tableView, indexPath))
        return stubbedTableViewCanEditRowAtResult
    }

    var invokedTableViewCanMoveRowAt = false
    var invokedTableViewCanMoveRowAtCount = 0
    var invokedTableViewCanMoveRowAtParameters: (tableView: UITableView, indexPath: IndexPath)?
    var invokedTableViewCanMoveRowAtParametersList = [(tableView: UITableView, indexPath: IndexPath)]()
    var stubbedTableViewCanMoveRowAtResult: Bool! = false

    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        invokedTableViewCanMoveRowAt = true
        invokedTableViewCanMoveRowAtCount += 1
        invokedTableViewCanMoveRowAtParameters = (tableView, indexPath)
        invokedTableViewCanMoveRowAtParametersList.append((tableView, indexPath))
        return stubbedTableViewCanMoveRowAtResult
    }

    var invokedSectionIndexTitles = false
    var invokedSectionIndexTitlesCount = 0
    var invokedSectionIndexTitlesParameters: (tableView: UITableView, Void)?
    var invokedSectionIndexTitlesParametersList = [(tableView: UITableView, Void)]()
    var stubbedSectionIndexTitlesResult: [String]!

    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        invokedSectionIndexTitles = true
        invokedSectionIndexTitlesCount += 1
        invokedSectionIndexTitlesParameters = (tableView, ())
        invokedSectionIndexTitlesParametersList.append((tableView, ()))
        return stubbedSectionIndexTitlesResult
    }

    var invokedTableViewSectionForSectionIndexTitle = false
    var invokedTableViewSectionForSectionIndexTitleCount = 0
    var invokedTableViewSectionForSectionIndexTitleParameters: (tableView: UITableView, title: String, index: Int)?
    var invokedTableViewSectionForSectionIndexTitleParametersList = [(tableView: UITableView, title: String, index: Int)]()
    var stubbedTableViewSectionForSectionIndexTitleResult: Int! = 0

    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        invokedTableViewSectionForSectionIndexTitle = true
        invokedTableViewSectionForSectionIndexTitleCount += 1
        invokedTableViewSectionForSectionIndexTitleParameters = (tableView, title, index)
        invokedTableViewSectionForSectionIndexTitleParametersList.append((tableView, title, index))
        return stubbedTableViewSectionForSectionIndexTitleResult
    }

    var invokedTableViewCommit = false
    var invokedTableViewCommitCount = 0
    var invokedTableViewCommitParameters: (tableView: UITableView, editingStyle: UITableViewCell.EditingStyle, indexPath: IndexPath)?
    var invokedTableViewCommitParametersList = [(tableView: UITableView, editingStyle: UITableViewCell.EditingStyle, indexPath: IndexPath)]()

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        invokedTableViewCommit = true
        invokedTableViewCommitCount += 1
        invokedTableViewCommitParameters = (tableView, editingStyle, indexPath)
        invokedTableViewCommitParametersList.append((tableView, editingStyle, indexPath))
    }

    var invokedTableViewMoveRowAt = false
    var invokedTableViewMoveRowAtCount = 0
    var invokedTableViewMoveRowAtParameters: (tableView: UITableView, sourceIndexPath: IndexPath, destinationIndexPath: IndexPath)?
    var invokedTableViewMoveRowAtParametersList = [(tableView: UITableView, sourceIndexPath: IndexPath, destinationIndexPath: IndexPath)]()

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        invokedTableViewMoveRowAt = true
        invokedTableViewMoveRowAtCount += 1
        invokedTableViewMoveRowAtParameters = (tableView, sourceIndexPath, destinationIndexPath)
        invokedTableViewMoveRowAtParametersList.append((tableView, sourceIndexPath, destinationIndexPath))
    }

    var invokedScrollViewDidScroll = false
    var invokedScrollViewDidScrollCount = 0
    var invokedScrollViewDidScrollParameters: (scrollView: UIScrollView, Void)?
    var invokedScrollViewDidScrollParametersList = [(scrollView: UIScrollView, Void)]()

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        invokedScrollViewDidScroll = true
        invokedScrollViewDidScrollCount += 1
        invokedScrollViewDidScrollParameters = (scrollView, ())
        invokedScrollViewDidScrollParametersList.append((scrollView, ()))
    }

    var invokedScrollViewDidZoom = false
    var invokedScrollViewDidZoomCount = 0
    var invokedScrollViewDidZoomParameters: (scrollView: UIScrollView, Void)?
    var invokedScrollViewDidZoomParametersList = [(scrollView: UIScrollView, Void)]()

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        invokedScrollViewDidZoom = true
        invokedScrollViewDidZoomCount += 1
        invokedScrollViewDidZoomParameters = (scrollView, ())
        invokedScrollViewDidZoomParametersList.append((scrollView, ()))
    }

    var invokedScrollViewWillBeginDragging = false
    var invokedScrollViewWillBeginDraggingCount = 0
    var invokedScrollViewWillBeginDraggingParameters: (scrollView: UIScrollView, Void)?
    var invokedScrollViewWillBeginDraggingParametersList = [(scrollView: UIScrollView, Void)]()

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        invokedScrollViewWillBeginDragging = true
        invokedScrollViewWillBeginDraggingCount += 1
        invokedScrollViewWillBeginDraggingParameters = (scrollView, ())
        invokedScrollViewWillBeginDraggingParametersList.append((scrollView, ()))
    }

    var invokedScrollViewWillEndDragging = false
    var invokedScrollViewWillEndDraggingCount = 0
    var invokedScrollViewWillEndDraggingParameters: (scrollView: UIScrollView, velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)?
    var invokedScrollViewWillEndDraggingParametersList = [(scrollView: UIScrollView, velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)]()

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        invokedScrollViewWillEndDragging = true
        invokedScrollViewWillEndDraggingCount += 1
        invokedScrollViewWillEndDraggingParameters = (scrollView, velocity, targetContentOffset)
        invokedScrollViewWillEndDraggingParametersList.append((scrollView, velocity, targetContentOffset))
    }

    var invokedScrollViewDidEndDragging = false
    var invokedScrollViewDidEndDraggingCount = 0
    var invokedScrollViewDidEndDraggingParameters: (scrollView: UIScrollView, decelerate: Bool)?
    var invokedScrollViewDidEndDraggingParametersList = [(scrollView: UIScrollView, decelerate: Bool)]()

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        invokedScrollViewDidEndDragging = true
        invokedScrollViewDidEndDraggingCount += 1
        invokedScrollViewDidEndDraggingParameters = (scrollView, decelerate)
        invokedScrollViewDidEndDraggingParametersList.append((scrollView, decelerate))
    }

    var invokedScrollViewWillBeginDecelerating = false
    var invokedScrollViewWillBeginDeceleratingCount = 0
    var invokedScrollViewWillBeginDeceleratingParameters: (scrollView: UIScrollView, Void)?
    var invokedScrollViewWillBeginDeceleratingParametersList = [(scrollView: UIScrollView, Void)]()

    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        invokedScrollViewWillBeginDecelerating = true
        invokedScrollViewWillBeginDeceleratingCount += 1
        invokedScrollViewWillBeginDeceleratingParameters = (scrollView, ())
        invokedScrollViewWillBeginDeceleratingParametersList.append((scrollView, ()))
    }

    var invokedScrollViewDidEndDecelerating = false
    var invokedScrollViewDidEndDeceleratingCount = 0
    var invokedScrollViewDidEndDeceleratingParameters: (scrollView: UIScrollView, Void)?
    var invokedScrollViewDidEndDeceleratingParametersList = [(scrollView: UIScrollView, Void)]()

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        invokedScrollViewDidEndDecelerating = true
        invokedScrollViewDidEndDeceleratingCount += 1
        invokedScrollViewDidEndDeceleratingParameters = (scrollView, ())
        invokedScrollViewDidEndDeceleratingParametersList.append((scrollView, ()))
    }

    var invokedScrollViewDidEndScrollingAnimation = false
    var invokedScrollViewDidEndScrollingAnimationCount = 0
    var invokedScrollViewDidEndScrollingAnimationParameters: (scrollView: UIScrollView, Void)?
    var invokedScrollViewDidEndScrollingAnimationParametersList = [(scrollView: UIScrollView, Void)]()

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        invokedScrollViewDidEndScrollingAnimation = true
        invokedScrollViewDidEndScrollingAnimationCount += 1
        invokedScrollViewDidEndScrollingAnimationParameters = (scrollView, ())
        invokedScrollViewDidEndScrollingAnimationParametersList.append((scrollView, ()))
    }

    var invokedViewForZooming = false
    var invokedViewForZoomingCount = 0
    var invokedViewForZoomingParameters: (scrollView: UIScrollView, Void)?
    var invokedViewForZoomingParametersList = [(scrollView: UIScrollView, Void)]()
    var stubbedViewForZoomingResult: UIView!

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        invokedViewForZooming = true
        invokedViewForZoomingCount += 1
        invokedViewForZoomingParameters = (scrollView, ())
        invokedViewForZoomingParametersList.append((scrollView, ()))
        return stubbedViewForZoomingResult
    }

    var invokedScrollViewWillBeginZooming = false
    var invokedScrollViewWillBeginZoomingCount = 0
    var invokedScrollViewWillBeginZoomingParameters: (scrollView: UIScrollView, view: UIView?)?
    var invokedScrollViewWillBeginZoomingParametersList = [(scrollView: UIScrollView, view: UIView?)]()

    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        invokedScrollViewWillBeginZooming = true
        invokedScrollViewWillBeginZoomingCount += 1
        invokedScrollViewWillBeginZoomingParameters = (scrollView, view)
        invokedScrollViewWillBeginZoomingParametersList.append((scrollView, view))
    }

    var invokedScrollViewDidEndZooming = false
    var invokedScrollViewDidEndZoomingCount = 0
    var invokedScrollViewDidEndZoomingParameters: (scrollView: UIScrollView, view: UIView?, scale: CGFloat)?
    var invokedScrollViewDidEndZoomingParametersList = [(scrollView: UIScrollView, view: UIView?, scale: CGFloat)]()

    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        invokedScrollViewDidEndZooming = true
        invokedScrollViewDidEndZoomingCount += 1
        invokedScrollViewDidEndZoomingParameters = (scrollView, view, scale)
        invokedScrollViewDidEndZoomingParametersList.append((scrollView, view, scale))
    }

    var invokedScrollViewShouldScrollToTop = false
    var invokedScrollViewShouldScrollToTopCount = 0
    var invokedScrollViewShouldScrollToTopParameters: (scrollView: UIScrollView, Void)?
    var invokedScrollViewShouldScrollToTopParametersList = [(scrollView: UIScrollView, Void)]()
    var stubbedScrollViewShouldScrollToTopResult: Bool! = false

    func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        invokedScrollViewShouldScrollToTop = true
        invokedScrollViewShouldScrollToTopCount += 1
        invokedScrollViewShouldScrollToTopParameters = (scrollView, ())
        invokedScrollViewShouldScrollToTopParametersList.append((scrollView, ()))
        return stubbedScrollViewShouldScrollToTopResult
    }

    var invokedScrollViewDidScrollToTop = false
    var invokedScrollViewDidScrollToTopCount = 0
    var invokedScrollViewDidScrollToTopParameters: (scrollView: UIScrollView, Void)?
    var invokedScrollViewDidScrollToTopParametersList = [(scrollView: UIScrollView, Void)]()

    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        invokedScrollViewDidScrollToTop = true
        invokedScrollViewDidScrollToTopCount += 1
        invokedScrollViewDidScrollToTopParameters = (scrollView, ())
        invokedScrollViewDidScrollToTopParametersList.append((scrollView, ()))
    }

    var invokedScrollViewDidChangeAdjustedContentInset = false
    var invokedScrollViewDidChangeAdjustedContentInsetCount = 0
    var invokedScrollViewDidChangeAdjustedContentInsetParameters: (scrollView: UIScrollView, Void)?
    var invokedScrollViewDidChangeAdjustedContentInsetParametersList = [(scrollView: UIScrollView, Void)]()

    func scrollViewDidChangeAdjustedContentInset(_ scrollView: UIScrollView) {
        invokedScrollViewDidChangeAdjustedContentInset = true
        invokedScrollViewDidChangeAdjustedContentInsetCount += 1
        invokedScrollViewDidChangeAdjustedContentInsetParameters = (scrollView, ())
        invokedScrollViewDidChangeAdjustedContentInsetParametersList.append((scrollView, ()))
    }
}
