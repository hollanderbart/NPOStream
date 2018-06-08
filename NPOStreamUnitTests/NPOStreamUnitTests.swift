//
//  NPOStreamUnitTests.swift
//  NPOStreamUnitTests
//
//  Created by Bart den Hollander on 06/06/2018.
//  Copyright © 2018 Bart den Hollander. All rights reserved.
//

import XCTest
@testable import NPOStream

class NPOStreamUnitTests: XCTestCase {

    func testAllStreamsAreDownloadable() {
        for channel in ChannelStreamTitle.allCases {
            NPOStream.getStream(channel) { (result) in
                guard case Result.success(_) = result else {
                    XCTFail("Should be succes")
                    return
                }
            }
        }
    }
    
    func testPerformance() {
        self.measure {
            testAllStreamsAreDownloadable()
        }
    }
}
