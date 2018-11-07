import Foundation

func step(_ description: String? = nil, _ action: TestActionable) {
    print(description)
    action.perform()
}
