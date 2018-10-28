import Foundation

typealias OnFetchTasks = (StorageResult<[Task]>) -> ()
typealias StorageResult<T> = Result<T, StorageError>
typealias OnStorageResult = (StorageResult<Void>) -> ()
