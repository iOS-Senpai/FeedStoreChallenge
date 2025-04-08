//
//  XCTestCase+FailableInsertFeedStoreSpecs.swift
//  Phoenix FrameworkTests
//
//  Created by xavient on 03/03/25.
//

import XCTest
import FeedStoreChallenge

extension FailableInsertFeedStoreSpecs where Self: XCTestCase {
    
    func assertThatInsertDeliversErroronInsertionError(on sut: FeedStore, file: StaticString = #filePath, line: UInt = #line) {
        let insertionError = insert((uniqueImageFeed(), Date()), to: sut)
        XCTAssertNotNil(insertionError, "Expected cache insertion fail with an error", file: file, line: line)
    }
    
    func assertThatInsertHasNoSideEffectsOnInsertionError(on sut: FeedStore, file: StaticString = #filePath, line: UInt = #line) {
        insert((uniqueImageFeed(), Date()), to: sut)
        expect(sut, toRetrieveWith: .empty, file: file, line: line)
    }
}
