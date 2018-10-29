import Foundation

typealias ListResult = StorageResult<[List]>
typealias TaskResult = StorageResult<[Task]>
typealias IdentifierResult = StorageResult<Identifier>
typealias GeneralResult = StorageResult<Void>

typealias OnStorageIndentifier = (IdentifierResult) -> ()
typealias OnFetchSingleList = (StorageResult<List>) -> ()
typealias OnFetchLists = (ListResult) -> ()
typealias OnFetchTasks = (TaskResult) -> ()
typealias StorageResult<T> = Result<T, StorageError>
typealias OnStorageResult = (GeneralResult) -> ()
