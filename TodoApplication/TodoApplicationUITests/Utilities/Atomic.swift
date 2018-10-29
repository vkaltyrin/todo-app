import Foundation

protocol Lock {
    func lock()
    func unlock()
}

final class UnfairLock: Lock {

    private var unfairLock = os_unfair_lock_s()

    // MARK: - Lock

    func lock() {
        os_unfair_lock_lock(&unfairLock)
    }

    func unlock() {
        os_unfair_lock_unlock(&unfairLock)
    }
}

final class Atomic<T> {
    private var lock = UnfairLock()

    private var underlyingValue: T

    init(_ value: T) {
        lock.lock()
        self.underlyingValue = value
        lock.unlock()
    }

    var value: T {
        get {
            lock.lock()
            let result = underlyingValue
            lock.unlock()
            return result
        }
        set {
            lock.lock()
            underlyingValue = newValue
            lock.unlock()
        }
    }
}
