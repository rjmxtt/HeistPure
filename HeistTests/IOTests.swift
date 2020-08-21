//
//  IOTests.swift
//  Heist1Tests
//
//  Created by rjm on 14/02/2020.
//  Copyright © 2020 rjm. All rights reserved.
//

import XCTest
@testable import Heist

class IOTests: XCTestCase {

    //Doesnt work whatever it is
//    func test1() {
//        let fix = Fixture(startChannel: 0, totalChannel: 1)
//
//        if let encoded = try? JSONEncoder().encode(fix) {
//            UserDefaults.standard.set(encoded, forKey: "fix")
//        }
//
//        if let fixData = UserDefaults.standard.data(forKey: "fix"),
//            let fix = try? JSONDecoder().decode(Fixture.self, from: fixData) {
//        }
//
//        print(fix.getTotalChannel())
//    }
//
//    //load fixtures into scene
//    func test2() {
//        print(">>> Test 2 <<<")
//        let io = ControllerIO()
//        let scene = Scene(sceneID: 000)
//
//        scene.constructFixArr(from: io.read()!)
//        print(scene.fixtureArray)
//        //break
//    }

    func test3() {
        print(">>> Test ShowIO <<<")
        let io = ShowIO()
        print(io.extractShow())
    }
    
}
