//
//  SceneTest.swift
//  Heist1Tests
//
//  Created by rjm on 06/12/2019.
//  Copyright © 2019 rjm. All rights reserved.
//

import XCTest
@testable import Heist

class SceneTest: XCTestCase {

    func testInit() {
        let scene = Scene(sceneID: 1)
        
        XCTAssertEqual(scene.getID(), 1)
    }
    
    func testFixtures() {
        let scene = Scene(sceneID:1)
        var fixArr = scene.getFixtureArray()
        
        let fix1 = Frasnel(startChannel: 0, totalChannel: 1)
        let fix2 = Frasnel(startChannel: 1, totalChannel: 1)
        fixArr.append(fix1)
        fixArr.append(fix2)
        
        XCTAssert(fixArr.count == 2)
        XCTAssert(fixArr[0].intensity == 0)
        XCTAssert(fixArr[1].intensity == 0)
        
        fixArr.map {
            do { try $0.setIntensity(newIntensity:255) }
            catch { print ("channel value out of bounds") }
        }
            
        XCTAssert(fixArr[0].intensity == 255)
        XCTAssert(fixArr[1].intensity == 255)
    }
    
    func testAddToFixArray() {
        let scene = Scene(sceneID: 0)
        let fix1 = Frasnel(startChannel: 0, totalChannel: 1)
        let fix2 = Frasnel(startChannel: 1, totalChannel: 1)
        
        scene.addToFixtureArray(fix:fix1)
        scene.addToFixtureArray(fix:fix2)
        
        let fixArr = scene.getFixtureArray()
        XCTAssert(fixArr.count == 2)
        XCTAssert(fixArr[0].intensity == 0)
        XCTAssert(fixArr[1].intensity == 0)
    }
    
    func testFuncMapping() {
        let scene = Scene(sceneID:1)
        var fixArr = scene.getFixtureArray()
        let fix1 = Frasnel(startChannel: 0, totalChannel: 1)
        let fix2 = Parcan(startChannel: 1, totalChannel: 5)
        fixArr.append(fix1)
        fixArr.append(fix2)
        
        for obj in fixArr {
            XCTAssertEqual(obj.getIntensity(), 0)
        }
        fixArr.map{
            do { try $0.stepChannelToValue(channel:Fixture.ChannelType.Intensity, value:255) }
            catch { print ("channel value out of bounds")}
        }
        for obj in fixArr {
            XCTAssertEqual(obj.getIntensity(), 255)
        }
        
        fixArr.map{ if $0 is Parcan {
            do { try $0.stepChannelToValue(channel:Fixture.ChannelType.Intensity, value:0) }
            catch { print ("channel value out of bounds")} }
        }
        
        for obj in fixArr {
            if obj is Parcan {
                XCTAssertEqual(obj.getIntensity(), 0)
            } else {
                XCTAssertEqual(obj.getIntensity(), 255)
            }
        }
    }
    
    func testStepOnDoubledUpFixtures() {
        let scene = Scene(sceneID:1)
        //let fix = Fixture(startChannel: 0, totalChannel: 0)
        let close = Closures()
        let fix1 = Frasnel(startChannel: 0, totalChannel: 1)
        let fix2 = Frasnel(startChannel: 1, totalChannel: 1)
        scene.addToFixtureArray(fix: fix1)
        scene.addToFixtureArray(fix: fix2)
        
        let stepToObj = close.getStepToValue(typeTag: Fixture.TypeTag.Frasnel, channel: Fixture.ChannelType.Intensity, value: 255)
        scene.addInstruction( instruction: stepToObj )
        let stepToObj1 = close.getStepToValue(typeTag: Fixture.TypeTag.Frasnel, channel: Fixture.ChannelType.Intensity, value: 0)
        scene.addInstruction( instruction: stepToObj1 )
        
        scene.step()
        var fixArr = scene.getFixtureArray()
        for obj in fixArr {
            XCTAssertEqual(obj.getIntensity(), 255)
        }
        scene.step()
        fixArr = scene.getFixtureArray()
        for obj in fixArr {
            XCTAssertEqual(obj.getIntensity(), 0)
        }
        scene.step()
        fixArr = scene.getFixtureArray()
        for obj in fixArr {
            XCTAssertEqual(obj.getIntensity(), 255)
        }
    }
    
    /*There is an assuption in this test that if one channel in a fixture type
     is responsive then the others will be as well*/
    func testStepOnFullFixSet() {
        let scene = Scene(sceneID:1)
        let close = Closures()
        var fixArr = scene.getFixtureArray()
        
        let fix1 = Frasnel(startChannel: 0, totalChannel: 1)
        let fix2 = Gobo(startChannel: 1, totalChannel: 2)
        let fix3 = Haze(startChannel: 3, totalChannel: 1)
        let fix4 = Parcan(startChannel: 4, totalChannel: 5)
        let fix5 = RotatingHead(startChannel: 9, totalChannel: 8)
        let fix6 = Laser(startChannel: 17, totalChannel: 30)
        
        scene.fixtureArray.append(fix1)
        scene.fixtureArray.append(fix2)
        scene.fixtureArray.append(fix3)
        scene.fixtureArray.append(fix4)
        scene.fixtureArray.append(fix5)
        scene.fixtureArray.append(fix6)
        
        //Frasnel Instructions
        let stepFrasIntensityTo255 = close.getStepToValue(typeTag: Fixture.TypeTag.Frasnel, channel: Fixture.ChannelType.Intensity, value: 255)
        scene.addInstruction(instruction: stepFrasIntensityTo255)
        let stepFrasIntensityTo000 = close.getStepToValue(typeTag: Fixture.TypeTag.Frasnel, channel: Fixture.ChannelType.Intensity, value: 0)
        scene.addInstruction(instruction: stepFrasIntensityTo000)
        
        //Gobo Instructions
        let stepGoboDiskTo255 = close.getStepToValue(typeTag: Fixture.TypeTag.Gobo, channel: Fixture.ChannelType.Disk, value: 255)
        scene.addInstruction(instruction: stepGoboDiskTo255)
        let stepGoboDiskTo000 = close.getStepToValue(typeTag: Fixture.TypeTag.Gobo, channel: Fixture.ChannelType.Disk, value: 0)
        scene.addInstruction(instruction: stepGoboDiskTo000)
        
        //Parcan Instructions
        let stepParRedTo255 = close.getStepToValue(typeTag: Fixture.TypeTag.Parcan, channel: Fixture.ChannelType.Red, value: 255)
        scene.addInstruction(instruction: stepParRedTo255)
        let stepParRedTo000 = close.getStepToValue(typeTag: Fixture.TypeTag.Parcan, channel: Fixture.ChannelType.Red, value: 0)
        scene.addInstruction(instruction: stepParRedTo000)
        
        //RotHead Instructions
        let stepRotPanTo255 = close.getStepToValue(typeTag: Fixture.TypeTag.RotatingHead, channel: Fixture.ChannelType.Pan, value: 255)
        scene.addInstruction(instruction: stepRotPanTo255)
        let stepRotPanTo000 = close.getStepToValue(typeTag: Fixture.TypeTag.RotatingHead, channel: Fixture.ChannelType.Pan, value: 0)
        scene.addInstruction(instruction: stepRotPanTo000)
        
        //Laser Instructions
        let stepLasPatTo255 = close.getStepToValue(typeTag: Fixture.TypeTag.Laser, channel: Fixture.ChannelType.Pattern, value: 255)
        scene.addInstruction(instruction: stepLasPatTo255)
        let stepLasPatTo000 = close.getStepToValue(typeTag: Fixture.TypeTag.Laser, channel: Fixture.ChannelType.Pattern, value: 0)
        scene.addInstruction(instruction: stepLasPatTo000)
        
        //Frasnel
        scene.step()
        fixArr = scene.getFixtureArray()
        for obj in fixArr {
            if let fras = obj as? Frasnel {
                XCTAssertEqual(fras.getIntensity(), 255)
            }
        }
        scene.step()
        fixArr = scene.getFixtureArray()
        for obj in fixArr {
            if let fras = obj as? Frasnel {
                XCTAssertEqual(fras.getIntensity(), 0)
            }
        }
        //Gobo
        scene.step()
        fixArr = scene.getFixtureArray()
        for obj in fixArr {
            if let gobo = obj as? Gobo {
                XCTAssertEqual(gobo.getDiskValue(), 255)
            } 
        }
        scene.step()
        fixArr = scene.getFixtureArray()
        for obj in fixArr {
            if let gobo = obj as? Gobo {
                XCTAssertEqual(gobo.getDiskValue(), 0)
            }
        }
        //Parcan
        scene.step()
        fixArr = scene.getFixtureArray()
        for obj in fixArr {
            if let par = obj as? Parcan {
                XCTAssertEqual(par.getRed(), 255)
            }
        }
        scene.step()
        fixArr = scene.getFixtureArray()
        for obj in fixArr {
            if let par = obj as? Parcan {
                XCTAssertEqual(par.getRed(), 0)
            }
        }
        //Rotating Head
        scene.step()
        fixArr = scene.getFixtureArray()
        for obj in fixArr {
            if let rot = obj as? RotatingHead {
                XCTAssertEqual(rot.getPan(), 255)
            }
        }
        scene.step()
        fixArr = scene.getFixtureArray()
        for obj in fixArr {
            if let rot = obj as? RotatingHead {
                XCTAssertEqual(rot.getPan(), 0)
            }
        }
    }
    
//    // Test closere only applys to desired type
//    func testNonOverlappingApplication() {
//        let scene = Scene(sceneID: 0)
//        let close = Closures()
//        let io = FixturesIO()
//
//        scene.constructFixArr(from: io.read()!)
//
//        let frasIntensityTo255 = close.getStepToValue(typeTag: Fixture.TypeTag.Frasnel, channel: Fixture.ChannelType.Intensity, value: 255)
//        scene.addInstruction(instruction: frasIntensityTo255)
//
//        for fix in scene.getFixtureArray() { XCTAssertEqual(fix.getIntensity(), 0) }
//        scene.step()
//        for obj in scene.getFixtureArray() {
//            if let pars = obj as? Parcan {
//                XCTAssertNotEqual(pars.getIntensity(), 255)
//            }
//        }
//    }
//
//    func testListWithArray() {
//        let scene = Scene(sceneID:0)
//        let close = Closures()
//        let io = FixturesIO()
//        scene.constructFixArr(from: io.read()!)
//
//        let frasIntensityTo255 = close.getStepToValue(typeTag: Fixture.TypeTag.Frasnel, channel: Fixture.ChannelType.Intensity, value: 255)
//        let parsIntensityTo255 = close.getStepToValue(typeTag: Fixture.TypeTag.Parcan, channel: Fixture.ChannelType.Intensity, value: 255)
//        let instructionArr = [frasIntensityTo255, parsIntensityTo255]
//        scene.addInstructionArr(toAdd: instructionArr)
//
//        for fix in scene.getFixtureArray() { XCTAssertEqual(fix.getIntensity(), 0) }
//        scene.step()
//        for fix in scene.getFixtureArray() { XCTAssertEqual(fix.getIntensity(), 255) }
//        //break
//    }
     
    func testSend() {
        let scene = Scene(sceneID:1)
        let fix1 = Frasnel(startChannel: 0, totalChannel: 1)
        let fix2 = Frasnel(startChannel: 1, totalChannel: 1)
        scene.fixtureArray.append(fix1)
        scene.fixtureArray.append(fix2)
        
        var arr = [UInt8](repeating: 0, count: 512)
        for i in 0...511 {
            XCTAssertEqual(arr[i], 0)
        }
        
        do { try fix1.setIntensity(newIntensity: 255) } catch { print ("err") }
        do { try fix2.setIntensity(newIntensity: 255) } catch { print ("err") }
        arr = scene.send()
        /*
        for i in 0...511 {
            if i == 0 || i == 1 {
                XCTAssertEqual(arr[i], 255)
            } else {
                XCTAssertEqual(arr[i], 0)
            }
        }
 */
    }
}
