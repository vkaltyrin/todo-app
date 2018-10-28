import Foundation

protocol ListPresenter: class {

}

final class ListPresenterImpl: ListPresenter {
    weak var view: ListView?
}
