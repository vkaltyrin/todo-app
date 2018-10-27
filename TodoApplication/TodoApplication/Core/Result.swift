public enum Result<T> {
    case success(T)
    case failure(Error)

    public typealias CompletionHandler = (Result) -> ()

    public func onSuccess(_ closure: (T) -> ()) {
        switch self {
        case .failure:
            break
        case .success(let data):
            closure(data)
        }
    }

    public func onFailure(_ closure: (Error) -> ()) {
        switch self {
        case .failure(let error):
            closure(error)
        case .success:
            break
        }
    }
}
