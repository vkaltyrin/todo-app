import Foundation

protocol ConfigurableCell {
    associatedtype ViewModel

    func configure(_ viewModel: ViewModel)
}
