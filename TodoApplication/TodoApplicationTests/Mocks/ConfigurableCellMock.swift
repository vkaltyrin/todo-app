@testable import TodoApplication
import XCTest

final class ConfigurableCellMock<ViewModel>: UITableViewCell, ConfigurableCell {

    var invokedConfigure = false
    var invokedConfigureCount = 0
    var invokedConfigureParameters: (viewModel: ViewModel, Void)?
    var invokedConfigureParametersList = [(viewModel: ViewModel, Void)]()

    func configure(_ viewModel: ViewModel) {
        invokedConfigure = true
        invokedConfigureCount += 1
        invokedConfigureParameters = (viewModel, ())
        invokedConfigureParametersList.append((viewModel, ()))
    }

    var invokedFocus = false
    var invokedFocusCount = 0

    func focus() {
        invokedFocus = true
        invokedFocusCount += 1
    }
}
