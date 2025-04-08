//
//  XCTestCase+FeedStoreSpecs.swift
//  Phoenix FrameworkTests
//
//  Created by xavient on 03/03/25.
//

import XCTest
import FeedStoreChallenge

extension FeedStoreSpecs where Self: XCTestCase {
    
    func assertThatRetrieveCacheDeliversEmptyOnEmptyCache(on sut: FeedStore, file: StaticString = #filePath, line: UInt = #line) {
        expect(sut, toRetrieveWith: .empty, file: file, line: line)
    }
    
    func assertThatRetrievCacheHasNoSideEffectsOnEmptyCache(on sut: FeedStore, file: StaticString = #filePath, line: UInt = #line) {
        expect(sut, toRetrieveTwice: .empty, file: file, line: line)
    }
    
    func assertThatRetrieveCacheDeliversFoundValuesOnNonEmptyCache(on sut: FeedStore, file: StaticString = #filePath, line: UInt = #line) {
        let feed = uniqueImageFeed()
        let currentDate = Date()
        
        insert((feed, currentDate), to: sut)
        
        expect(sut, toRetrieveWith: .found(feed: feed, timestamp: currentDate), file: file, line: line)
    }
    
    func assertThatRetrievCacheHasNoSideEffectsOnNonEmptyCache(on sut: FeedStore, file: StaticString = #filePath, line: UInt = #line) {
        let feed = uniqueImageFeed()
        let currentDate = Date()
        
        insert((feed, currentDate), to: sut)
        
        expect(sut, toRetrieveTwice: .found(feed: feed, timestamp: currentDate), file: file, line: line)
    }
    
    func assertThatInsertDeliversNoErrorOnEmptyCache(on sut: FeedStore, file: StaticString = #filePath, line: UInt = #line) {
        let insertionError = insert((uniqueImageFeed(), Date()), to: sut)
        
        XCTAssertNil(insertionError, "Expected to insert the cache succesfully", file: file, line: line)
    }
    
    func assertThatInsertDeliversNoErrorOnNonEmptyCache(on sut: FeedStore, file: StaticString = #filePath, line: UInt = #line) {
        insert((uniqueImageFeed(), Date()), to: sut)
        
        let insertionError = insert((uniqueImageFeed(), Date()), to: sut)
        
        XCTAssertNil(insertionError, "Expected to override the cache successfully", file: file, line: line)
    }
    
    func assertThatInsertOverridesPreviouslyInsertedCache(on sut: FeedStore, file: StaticString = #filePath, line: UInt = #line) {
        insert((uniqueImageFeed(), Date()), to: sut)
        
        let latestFeed = uniqueImageFeed()
        let latestDate = Date()
        insert((latestFeed, latestDate), to: sut)
        
        expect(sut, toRetrieveWith: .found(feed: latestFeed, timestamp: latestDate), file: file, line: line)
    }
    
    func assertThatDeleteDeliversNoErrorOnEmptyCache(on sut: FeedStore, file: StaticString = #filePath, line: UInt = #line) {
        let deletionError = delete(from: sut)
        
        XCTAssertNil(deletionError, "Expected empty cache deletion to be succeed", file: file, line: line)
    }
    
    func assertThatDeleteHasNoSideEffectsOnEmptyCache(on sut: FeedStore, file: StaticString = #filePath, line: UInt = #line) {
        delete(from: sut)
        expect(sut, toRetrieveWith: .empty, file: file, line: line)
    }
    
    func assertThatDeleteDeliversNoErrorOnNonEmptyCache(on sut: FeedStore, file: StaticString = #filePath, line: UInt = #line) {
        insert((uniqueImageFeed(), Date()), to: sut)
        let deletionError = delete(from: sut)
        XCTAssertNil(deletionError, "Expected non empty cache deletion to be succeed", file: file, line: line)
    }
    
    func assertThatDeleteEmptiesPreviouslyInsertedCache(on sut: FeedStore, file: StaticString = #filePath, line: UInt = #line) {
        insert((uniqueImageFeed(), Date()), to: sut)
        delete(from: sut)
        expect(sut, toRetrieveWith: .empty, file: file, line: line)
    }
    
    func assertThatStoreSideEffectsRunsSerially(on sut: FeedStore, file: StaticString = #filePath, line: UInt = #line) {
        var completedOpearationsInorder = [XCTestExpectation]()
        
        let op1 = expectation(description: "operation 1")
        sut.insert(uniqueImageFeed(), timestamp: Date.now) { _ in
            completedOpearationsInorder.append(op1)
            op1.fulfill()
        }
        
        let op2 = expectation(description: "operation 2")
        sut.deleteCacheFeed { _ in
            completedOpearationsInorder.append(op2)
            op2.fulfill()
        }
        
        let op3 = expectation(description: "operation 3")
        sut.insert(uniqueImageFeed(), timestamp: Date.now) { _ in
            completedOpearationsInorder.append(op3)
            op3.fulfill()
        }
        
        waitForExpectations(timeout: 5.0)
        
        XCTAssertEqual(completedOpearationsInorder, [op1, op2, op3], "Expected side effects to run serially but operations finished in wrong order.", file: file, line: line)
    }
}

extension FeedStoreSpecs where Self: XCTestCase {
    
    func uniqueImageFeed() -> [LocalFeedImage] {
        return [uniqueImage(), uniqueImage()]
    }
    
    func uniqueImage() -> LocalFeedImage {
        return LocalFeedImage(id: UUID(), description: "any", location: "any", url: anyURL())
    }
    
    func anyURL() -> URL {
        return URL(string: "https://any-url.com/")!
    }

    func anyNSError() -> NSError {
        return NSError(domain: "Any Error", code: 1)
    }
    
    @discardableResult
    func insert(_ cache: (feed: [LocalFeedImage], timestamp: Date), to sut: FeedStore, file: StaticString = #filePath, line: UInt = #line) -> Error? {
        let exp = expectation(description: "wait for cache insertion")
        var capturedError: Error?
        sut.insert(cache.feed, timestamp: cache.timestamp) { insertionError in
            capturedError = insertionError
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
        return capturedError
    }
    
    @discardableResult
    func delete(from sut: FeedStore) -> Error? {
        let exp = expectation(description: "wait for delete completion")
        var capturedError: Error?
        sut.deleteCacheFeed { deletionError in
            capturedError = deletionError
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
        return capturedError
    }
    
    func expect(_ sut: FeedStore, toRetrieveTwice expectedResult: CacheRetrievalResult, file: StaticString = #filePath, line: UInt = #line) {
        expect(sut, toRetrieveWith: expectedResult, file: file, line: line)
        expect(sut, toRetrieveWith: expectedResult, file: file, line: line)
    }
    
    func expect(_ sut: FeedStore, toRetrieveWith expectedResult: CacheRetrievalResult, file: StaticString = #filePath, line: UInt = #line) {
        let exp = expectation(description: "wait for cache retrieval")
        
        sut.retrieveCache { retrievedResult in
            switch (retrievedResult, expectedResult)  {
            case (.empty, .empty),
                (.failure, .failure)
                : break
            case let (.found(retrievedFeed, retrievedTimestamp), .found(expectedFeed, expectedTimestamp)):
                XCTAssertEqual(retrievedFeed, expectedFeed, file: file, line: line)
                XCTAssertEqual(retrievedTimestamp, expectedTimestamp, file: file, line: line)
            default:
                XCTFail("Expected to retrieve \(expectedResult), but got \(retrievedResult) instead", file: file, line: line)
            }
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }
}
