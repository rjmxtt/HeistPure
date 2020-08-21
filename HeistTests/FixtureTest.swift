//
//  FixtureTest.swift
//  HeistTests
//
//  Created by rjm on 26/03/2020.
//  Copyright © 2020 rjm. All rights reserved.
//

import XCTest
@testable import Heist

class FixtureTest: XCTestCase {

    func testAudioReferences() {
        let amp = Amplitude()
        //let fix = Fixture(startChannel: 0, totalChannel: 0)
        
        let amp2 = amp
        XCTAssertEqual(0, amp2.val)
        
        amp.val = 1
        XCTAssertEqual(1, amp2.val)
        print(amp2.val)
    }
    // this case however maps poorly onto requried functionality
}
