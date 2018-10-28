import Foundation

typealias ListResult = StorageResult<[List]>
typealias TaskResult = StorageResult<[Task]>

typealias OnFetchLists = (ListResult) -> ()
typealias OnFetchTasks = (TaskResult) -> ()
typealias StorageResult<T> = Result<T, StorageError>
typealias OnStorageResult = (StorageResult<Void>) -> ()
