public enum Result<T, E> {
    case success(T)
    case failure(E)

    public typealias CompletionHandler = (Result) -> ()

    public func onSuccess(_ closure: (T) -> ()) {
        switch self {
        case .failure:
            break
        case .success(let data):
            closure(data)
        }
    }

    public func onFailure(_ closure: (E) -> ()) {
        switch self {
        case .failure(let error):
            closure(error)
        case .success:
            break
        }
    }
}
