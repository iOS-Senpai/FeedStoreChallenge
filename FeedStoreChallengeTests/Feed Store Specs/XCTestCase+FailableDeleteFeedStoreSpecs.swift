//
//  XCTestCase+FailableDeleteFeedStoreSpecs.swift
//  Phoenix FrameworkTests
//
//  Created by xavient on 03/03/25.
//

import XCTest
import FeedStoreChallenge

extension FailableDeleteFeedStoreSpecs where Self: XCTestCase {
    
    func assertThatDeleteDeliversErrorOnDeletionError(on sut: FeedStore, file: StaticString = #filePath, line: UInt = #line) {
        let deletionError = delete(from: sut)
        XCTAssertNotNil(deletionError, "Expected cache deletion to fail", file: file, line: line)
    }
    
    func assertThatDeleteHasNoSideEffectsOnDeletionError(on sut: FeedStore, file: StaticString = #filePath, line: UInt = #line) {
        delete(from: sut)
        expect(sut, toRetrieveWith: .empty, file: file, line: line)
    }
}
