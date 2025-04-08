//
//  FeedStoreSpecs.swift
//  Phoenix FrameworkTests
//
//  Created by xavient on 03/03/25.
//

typealias FailableFeedStoreSpecs = FailableRetrievFeedStoreSpecs & FailableInsertFeedStoreSpecs & FailableDeleteFeedStoreSpecs

protocol FeedStoreSpecs {
     func test_retrieveCache_deliversEmptyOnEmptyCache() throws
     func test_retrieveCache_hasNoSideEffectsOnEmptyCache() throws
     func test_retrieve_deliversFoundValuesOnNonEmptyCache() throws
     func test_retrieve_hasNoSideEffectsOnNonEmptyCache() throws
       
     func test_insert_deliversNoErrorOnEmptyCache() throws
     func test_insert_deliversNoErrorOnNonEmptyCache() throws
     func test_insert_overridesPreviouslyInsertedCache() throws
         
     func test_delete_deliversNoErrorOnEmptyCache() throws
     func test_delete_hasNoSideEffectsOnEmptyCache() throws
     func test_delete_deliversNoErrorOnNonEmptyCache() throws
     func test_delete_emptiesPreviouslyInsertedCache() throws
    
     func test_storeSideEffects_runSerially() throws
}

protocol FailableRetrievFeedStoreSpecs: FeedStoreSpecs {
    func test_retrieve_deliversFailureOnRetrievalError() throws
    func test_retrieve_hasNoSideEffectsOnFailure() throws
}

protocol FailableInsertFeedStoreSpecs: FeedStoreSpecs {
    func test_insert_deliversErrorOnInsertionError() throws
    func test_insert_hasNoSideEffectsOnInsertionError() throws
}

protocol FailableDeleteFeedStoreSpecs: FeedStoreSpecs {
    func test_delete_deliversErrorOnDeletionError() throws
    func test_delete_hasNoSideEffectsOnDeletionError() throws
}
