//
//  XCTestCase+FeedStoreHelpers.swift
//  FeedStoreChallengeTests
//
//  Created by xavient on 08/04/25.
//

import XCTest
import FeedStoreChallenge

extension XCTestCase {
    
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
