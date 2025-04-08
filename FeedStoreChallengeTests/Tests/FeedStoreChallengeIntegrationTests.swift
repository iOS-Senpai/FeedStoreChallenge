//
//  FeedStoreChallengeIntegrationTests.swift
//  FeedStoreChallengeTests
//
//  Created by xavient on 08/04/25.
//

import XCTest
import FeedStoreChallenge

final class FeedStoreChallengeIntegrationTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        setupEmptyStoreState()
    }
    
    override func tearDown() {
        super.tearDown()
        undoStoreSideEffects()
    }
    
    func test_retrieve_deliversEmptyOnEmptyCache() {
//        let sut = makeSUT()
//        expect(sut, toRetrieveWith: .empty)
    }
    
    func test_retrieve_deliversFeedInsertedOnAnotherInstance() {
//        let storeToInsert = makeSUT()
//        let storeToLoad = makeSUT()
//        let feed = uniqueImageFeed()
//        let timestamp = Date()
//        
//        insert((feed: feed, timestamp: timestamp), to: storeToInsert)
//        
//        expect(storeToLoad, toRetrieveWith: .found(feed: feed, timestamp: timestamp))
    }
    
    func test_retrieve_overridesFeedInsertedOnAnotherInstance() {
//        let storeToInsert = makeSUT()
//        let storeToOverride = makeSUT()
//        let storeToLoad = makeSUT()
//      
//        insert((feed: uniqueImageFeed(), timestamp: Date()), to: storeToInsert)
//        
//        let latestFeed = uniqueImageFeed()
//        let latestTimeStamp = Date()
//        
//        insert((feed: latestFeed, timestamp: latestTimeStamp), to: storeToOverride)
//        
//        expect(storeToLoad, toRetrieveWith: .found(feed: latestFeed, timestamp: latestTimeStamp))
    }
    
    func test_delete_deletesFeedInsertedOnAnotherInstance() {
//        let storeToInsert = makeSUT()
//        let storeToDelete = makeSUT()
//        let storeToLoad = makeSUT()
//        
//        insert((feed: uniqueImageFeed(), timestamp: Date()), to: storeToInsert)
//        
//        delete(from: storeToDelete)
//        
//        expect(storeToLoad, toRetrieveWith: .empty)
    }
    
    // MARK: - Helpers
    
    private func makeSUT() -> FeedStore {
        fatalError("Implementation should be done.")
    }
    
    private func setupEmptyStoreState() { }
    
    private func undoStoreSideEffects() { }
}
