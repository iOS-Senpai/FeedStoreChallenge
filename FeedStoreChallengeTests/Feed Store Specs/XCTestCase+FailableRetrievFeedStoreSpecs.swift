//
//  XCTestCase+FailableRetrievFeedStoreSpecs.swift
//  Phoenix FrameworkTests
//
//  Created by xavient on 03/03/25.
//

import XCTest
import FeedStoreChallenge

extension FailableRetrievFeedStoreSpecs where Self: XCTestCase {
    
    func assertThatRetrieveDeliversFailureOnRetrievalError(on sut: FeedStore, file: StaticString = #filePath, line: UInt = #line) {
        expect(sut, toRetrieveWith: .failure(anyNSError()), file: file, line: line)
    }
    
    func assertThatRetrieveHasNoSideEffectsOnFailure(on sut: FeedStore, file: StaticString = #filePath, line: UInt = #line) {
        expect(sut, toRetrieveTwice: .failure(anyNSError()))
    }
}
