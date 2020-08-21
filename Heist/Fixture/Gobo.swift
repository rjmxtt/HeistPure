//
//  Gobo.swift
//  Heist1
//
//  Created by rjm on 16/12/2019.
//  Copyright © 2019 rjm. All rights reserved.
//

import Foundation

class Gobo : Fixture {
    //internal var diskValue : Int
    //internal var speedValue : Int
    //let type = "gobo"
    
    override init(startChannel: Int, totalChannel: Int) {
        super.init(startChannel: startChannel, totalChannel: totalChannel)
        super.setTypeTag(tag:TypeTag.Gobo)
        disk = 0
        speed = 0
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        let sC = try container.decode(Int.self, forKey: .startChannel)
        let tC = try container.decode(Int.self, forKey: .totalChannel)
        super.init(startChannel: sC, totalChannel: tC)
        super.setTypeTag(tag:TypeTag.Gobo)
        disk = 0
        speed = 0
    }
    
//    required init(from decoder: Decoder) throws {
//        fatalError("init(from:) has not been implemented")
//    }
    
    public func getDiskValue() -> Int {
        if disk == -1 {
            return Int(AudioFile.sharedAudio.getAmp() * 255)
        } else {
            return disk!
        }
    }
    
    public func setDiskValue(newDiskValue: Int) throws {
        if newDiskValue > 255 || newDiskValue < 0 {
            throw FixtureError.channelValueOutOfBounds
        } else {
            disk = newDiskValue
        }
    }
    
    public func getSpeedValue() -> Int {
        if speed == -1 {
            return Int(AudioFile.sharedAudio.getAmp() * 255)
        } else {
            return speed!
        }
    }
    
    public func setSpeedValue(newSpeedValue: Int) throws {
        if newSpeedValue > 255 || newSpeedValue < 0 {
            throw FixtureError.channelValueOutOfBounds
        } else {
            speed = newSpeedValue
        }
    }
        
    override func stepChannelToValue(channel: Fixture.ChannelType, value: Int) throws {
        switch channel {
            case ChannelType.Disk :
                do { try self.setDiskValue(newDiskValue: value) } catch { print ("channel value out of bounds") }
            case ChannelType.Speed :
                do { try self.setSpeedValue(newSpeedValue: value) } catch { print ("channel value out of bounds") }
            default:
                throw FixtureError.nonRelevantChannel
        }
    }
    
    override func send() -> [UInt8]{
        return [UInt8(getIntensity()),
                UInt8(getDiskValue()),
                UInt8(getSpeedValue())]
    }
}
