import Foundation

// Appcode mock generator creates stubs that takes tuple as a function parameter.
// Stub class is intended to hide this implementation detail in tests.
// Waiting for this https://github.com/apple/swift-evolution/blob/master/proposals/0216-dynamic-callable.md

typealias StubbedValue<T> = (T, Void)

final class Stub<T> {    
    static func create(_ value: T) -> StubbedValue<T> {
        return (value, ())
    }
}
