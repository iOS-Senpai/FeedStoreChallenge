//
//  FeedStore.swift
//  Phoenix Framework
//
//  Created by xavient on 07/02/25.
//

public enum CacheRetrievalResult {
    case empty
    case found(feed: [LocalFeedImage], timestamp: Date)
    case failure(Error)
}

public protocol FeedStore {
    typealias DeletionCompletion = (Error?) -> Void
    typealias InsertionCompletion = (Error?) -> Void
    typealias RetrievalCompletion = (CacheRetrievalResult) -> Void
    
    /// The Completion Handler can be invoked in any thread.
    /// Clients are responsible to dispatch to appropriate threads, if needed.
    func deleteCacheFeed(completion: @escaping DeletionCompletion) // TOP Level Exposed API's
    
    /// The Completion Handler can be invoked in any thread.
    /// Clients are responsible to dispatch to appropriate threads, if needed.
    func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion)
    
    /// The Completion Handler can be invoked in any thread.
    /// Clients are responsible to dispatch to appropriate threads, if needed.
    func retrieveCache(completion: @escaping RetrievalCompletion)
} // Public FeeStore Interface
