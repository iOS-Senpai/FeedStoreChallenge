//
//  FeedStoreChallengeTests.swift
//  FeedStoreChallengeTests
//
//  Created by xavient on 04/04/25.
//

import XCTest
import FeedStoreChallenge

final class FeedStoreChallengeTests: XCTestCase, FeedStoreSpecs {
    
    func test_retrieveCache_deliversEmptyOnEmptyCache() throws {
        let sut = makeSUT()
        assertThatRetrieveCacheDeliversEmptyOnEmptyCache(on: sut)
    }
    
    func test_retrieveCache_hasNoSideEffectsOnEmptyCache() throws {
//        let sut = makeSUT()
//        assertThatRetrievCacheHasNoSideEffectsOnEmptyCache(on: sut)
    }
    
    func test_retrieve_deliversFoundValuesOnNonEmptyCache() throws {
//        let sut = makeSUT()
//        assertThatRetrieveCacheDeliversFoundValuesOnNonEmptyCache(on: sut)
    }
    
    func test_retrieve_hasNoSideEffectsOnNonEmptyCache() throws {
//        let sut = makeSUT()
//        assertThatRetrievCacheHasNoSideEffectsOnNonEmptyCache(on: sut)
    }
    
    func test_insert_deliversNoErrorOnEmptyCache() throws {
//        let sut = makeSUT()
//        assertThatInsertDeliversNoErrorOnEmptyCache(on: sut)
    }
    
    func test_insert_deliversNoErrorOnNonEmptyCache() throws {
//        let sut = makeSUT()
//        assertThatInsertDeliversNoErrorOnNonEmptyCache(on: sut)
    }
    
    func test_insert_overridesPreviouslyInsertedCache() throws {
//        let sut = makeSUT()
//        assertThatInsertOverridesPreviouslyInsertedCache(on: sut)
    }
    
    func test_delete_deliversNoErrorOnEmptyCache() throws {
//        let sut = makeSUT()
//        assertThatDeleteDeliversNoErrorOnEmptyCache(on: sut)
    }
    
    func test_delete_hasNoSideEffectsOnEmptyCache() throws {
//        let sut = makeSUT()
//        assertThatDeleteHasNoSideEffectsOnEmptyCache(on: sut)
    }
    
    func test_delete_deliversNoErrorOnNonEmptyCache() throws {
//        let sut = makeSUT()
//        assertThatDeleteDeliversNoErrorOnNonEmptyCache(on: sut)
    }
    
    func test_delete_emptiesPreviouslyInsertedCache() throws {
//        let sut = makeSUT()
//        assertThatDeleteEmptiesPreviouslyInsertedCache(on: sut)
    }
    
    func test_storeSideEffects_runSerially() throws {
//        let sut = makeSUT()
//        assertThatStoreSideEffectsRunsSerially(on: sut)
    }
    
    // MARK: - Helpers
    
    private func makeSUT() -> FeedStore {
        fatalError("TODO Implemention")
    }
}

// MARK: - FailableRetrievFeedStoreSpecs

//extension FeedStoreChallengeTests: FailableRetrievFeedStoreSpecs {
//    func test_retrieve_deliversFailureOnRetrievalError() throws {
//        let sut = makeSUT()
//        assertThatRetrieveDeliversFailureOnRetrievalError(on: sut)
//    }
//    
//    func test_retrieve_hasNoSideEffectsOnFailure() throws {
//        let sut = makeSUT()
//        assertThatRetrieveHasNoSideEffectsOnFailure(on: sut)
//    }
//}

// MARK: - FailableInsertFeedStoreSpecs

//extension FeedStoreChallengeTests: FailableInsertFeedStoreSpecs {
//    func test_insert_deliversErrorOnInsertionError() throws {
//        let sut = makeSUT()
//        assertThatInsertDeliversErroronInsertionError(on: sut)
//    }
//    
//    func test_insert_hasNoSideEffectsOnInsertionError() throws {
//        let sut = makeSUT()
//        assertThatInsertHasNoSideEffectsOnInsertionError(on: sut)
//    }
//}

// MARK: - FailableDeleteFeedStoreSpecs

//extension FeedStoreChallengeTests: FailableDeleteFeedStoreSpecs {
//    func test_delete_deliversErrorOnDeletionError() throws {
//        let sut = makeSUT()
//        assertThatDeleteDeliversErrorOnDeletionError(on: sut)
//    }
//    
//    func test_delete_hasNoSideEffectsOnDeletionError() throws {
//        let sut = makeSUT()
//        assertThatDeleteHasNoSideEffectsOnDeletionError(on: sut)
//    }
//}
