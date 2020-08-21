//
//  Laser.swift
//  Heist1
//
//  Created by rjm on 17/12/2019.
//  Copyright © 2019 rjm. All rights reserved.
//

import Foundation

class Laser : ColourFixture {
    //internal var pattern, speed : Int
    //let type = "laser"
    
    override init(startChannel: Int, totalChannel: Int) {
        super.init(startChannel: startChannel, totalChannel: totalChannel)
        super.setTypeTag(tag:TypeTag.Laser)
        pattern = 0
        speed = 0
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
//    required init(from decoder: Decoder) throws {
//        fatalError("init(from:) has not been implemented")
//    }
    
    public func getPattern() -> Int {
        if intensity == -1 {
            return Int(AudioFile.sharedAudio.getAmp() * 255)
        } else {
            return pattern!
        }
    }
    
    public func getSpeed() -> Int {
        if intensity == -1 {
            return Int(AudioFile.sharedAudio.getAmp() * 255)
        } else {
            return speed!
        }
    }
    
    public func setPattern(newPattern: Int) throws {
        if newPattern > 255 || newPattern < 0 {
            throw FixtureError.channelValueOutOfBounds
        } else {
            self.pattern = newPattern
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
                do { try super.setIntensity(newIntensity: value) } catch { print ("channel value out of bounds") }
            case ChannelType.Red :
                do { try super.setRed(newRed: value) } catch { print ("channel value out of bounds") }
            case ChannelType.Green :
                do { try super.setGreen(newGreen: value) } catch { print ("channel value out of bounds") }
            case ChannelType.Blue :
                do { try super.setBlue(newBlue: value) } catch { print ("channel value out of bounds") }
            case ChannelType.Strobe :
                do { try super.setStrobe(newStrobe: value) } catch { print ("channel value out of bounds") }
            case ChannelType.Speed :
                do { try self.setSpeed(newSpeed: value) } catch { print ("channel value out of bounds") }
            case ChannelType.Pattern :
                do { try self.setPattern(newPattern: value) } catch { print ("channel value out of bounds") }
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
                UInt8(getPattern()),
                UInt8(getStrobe())]
    }
}
