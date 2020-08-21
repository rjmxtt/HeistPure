//
//  RotatingHead.swift
//  Heist1
//
//  Created by rjm on 17/12/2019.
//  Copyright © 2019 rjm. All rights reserved.
//

import Foundation

class RotatingHead : ColourFixture {
    //internal var pan, tilt, speed : Int
    //let type = "rotHead"
    
    override init(startChannel: Int, totalChannel: Int) {
        super.init(startChannel: startChannel, totalChannel: totalChannel)
        super.setTypeTag(tag:TypeTag.RotatingHead)
        pan = 0
        tilt = 0
        speed = 0
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
//    required init(from decoder: Decoder) throws {
//        fatalError("init(from:) has not been implemented")
//    }
    
    public func getPan() -> Int {
        if pan == -1 {
            return Int(AudioFile.sharedAudio.getAmp() * 255)
        } else {
            return pan!
        }
    }
    
    public func getTilt() -> Int {
        if tilt == -1 {
            return Int(AudioFile.sharedAudio.getAmp() * 255)
        } else {
            return tilt!
        }
    }
    
    public func getSpeed() -> Int {
        if speed == -1 {
            return Int(AudioFile.sharedAudio.getAmp() * 255)
        } else {
            return speed!
        }
    }
    
    public func setPan(newPan: Int) throws {
        if newPan > 255 || newPan < 0 {
            throw FixtureError.channelValueOutOfBounds
        } else {
            self.pan = newPan
        }
    }
    
    public func setTilt(newTilt: Int) throws {
        if newTilt > 255 || newTilt < 0 {
            throw FixtureError.channelValueOutOfBounds
        } else {
            self.tilt = newTilt
        }
    }
    
    public func setSpeed(newSpeed: Int) throws {
        if newSpeed > 255 || newSpeed < 0 {
            throw FixtureError.channelValueOutOfBounds
        } else {
            self.speed = newSpeed
        }
    }
    
    override func stepChannelToValue(channel: Fixture.ChannelType, value: Int) throws {
        switch channel {
            case ChannelType.Intensity :
                do { try super.setIntensity(newIntensity: value) }  catch { print ("channel value out of bounds") }
            case ChannelType.Red :
                do { try super.setRed(newRed: value) }  catch { print ("channel value out of bounds") }
            case ChannelType.Green :
                do { try super.setGreen(newGreen: value) }  catch { print ("channel value out of bounds") }
            case ChannelType.Blue :
                do { try super.setBlue(newBlue: value) }  catch { print ("channel value out of bounds") }
            case ChannelType.Strobe :
                do { try super.setStrobe(newStrobe: value) }  catch { print ("channel value out of bounds") }
            case ChannelType.Pan :
                do { try self.setPan(newPan: value) }  catch { print ("channel value out of bounds") }
            case ChannelType.Tilt :
                do { try self.setTilt(newTilt: value) }  catch { print ("channel value out of bounds") }
            case ChannelType.Speed :
                do { try self.setSpeed(newSpeed: value) }  catch { print ("channel value out of bounds") }
            default:
                throw FixtureError.nonRelevantChannel
        }
    }
    
    override func send() -> [UInt8] {
        return [UInt8(getIntensity()),
                UInt8(getRed()),
                UInt8(getGreen()),
                UInt8(getBlue()),
                UInt8(getStrobe()),
                UInt8(getPan()),
                UInt8(getTilt()),
                UInt8(getStrobe())]
    }
}
