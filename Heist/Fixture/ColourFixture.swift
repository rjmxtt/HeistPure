//
//  ColourFixture.swift
//  Heist1
//
//  Created by rjm on 17/12/2019.
//  Copyright © 2019 rjm. All rights reserved.
//

import Foundation

class ColourFixture : Fixture {
    //internal var red, green, blue, strobe : Int?
    
//    override init() {
//        super.init()
//        red = 999
//        green = 999
//        blue = 999
//        strobe = 999
//    }
    
    override init(startChannel: Int, totalChannel: Int) {
        super.init(startChannel: startChannel, totalChannel: totalChannel)
        red = 0
        green = 0
        blue = 0
        strobe = 0
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        let sC = try container.decode(Int.self, forKey: .startChannel)
        let tC = try container.decode(Int.self, forKey: .totalChannel)
        super.init(startChannel: sC, totalChannel: tC)
        red = 0
        green = 0
        blue = 0
        strobe = 0
    }
    
    public func getRed() -> Int {
        if red == -1 {
            return Int(AudioFile.sharedAudio.getAmp() * 255)
        } else {
            return red!
        }    }
    
    public func getGreen() -> Int {
        if green == -1 {
            return Int(AudioFile.sharedAudio.getAmp() * 255)
        } else {
            return green!
        }
    }
    
    public func getBlue() -> Int {
        if blue == -1 {
            return Int(AudioFile.sharedAudio.getAmp() * 255)
        } else {
            return blue!
        }
    }
    
    public func getStrobe() -> Int {
        if strobe == -1 {
            return Int(AudioFile.sharedAudio.getAmp() * 255)
        } else {
            return strobe!
        }
    }
    
    public func setRed(newRed: Int) throws {
        if newRed > 255 || newRed < 0 {
            throw FixtureError.channelValueOutOfBounds
        } else {
            self.red = newRed
        }
    }
    
    public func setGreen(newGreen: Int) throws {
        if newGreen > 255 || newGreen < 0 {
            throw FixtureError.channelValueOutOfBounds
        } else {
            self.green = newGreen
        }
    }
    
    public func setBlue(newBlue: Int) throws {
        if newBlue > 255 || newBlue < 0 {
            throw FixtureError.channelValueOutOfBounds
        } else {
            self.blue = newBlue
        }
    }
    
    public func setStrobe(newStrobe: Int) throws {
        if newStrobe > 255 || newStrobe < 0 {
            throw FixtureError.channelValueOutOfBounds
        } else {
            self.strobe = newStrobe
        }
    }
    
    override func stepChannelToValue(channel: Fixture.ChannelType, value: Int) throws {
        switch channel {
            case ChannelType.Intensity :
                do { try super.setIntensity(newIntensity: value) }  catch { print ("channel value out of bounds") }
            case ChannelType.Red :
                do { try self.setRed(newRed: value) }  catch { print ("channel value out of bounds") }
            case ChannelType.Green :
                do { try self.setGreen(newGreen: value) }  catch { print ("channel value out of bounds") }
            case ChannelType.Blue :
                do { try self.setBlue(newBlue: value) }  catch { print ("channel value out of bounds") }
            case ChannelType.Strobe :
                do { try self.setStrobe(newStrobe: value) }  catch { print ("channel value out of bounds") }
            default:
                throw FixtureError.nonRelevantChannel
        }
    }
    
    /**
     Set fixture to RGB value
     
     - parameter : red
     - parameter : green
     - parameter : blue
     */
    public func colourWash(red: Int, green: Int, blue: Int) {
        do {try self.setRed(newRed: red)} catch { print ("channel value out of bounds")}
        do {try self.setGreen(newGreen: green)} catch { print ("channel value out of bounds")}
        do {try self.setBlue(newBlue: blue)} catch { print ("channel value out of bounds")}
    }
    
    /**
     Fades fixture to new colour value
     
     - parameter : red
     - parameter : green
     - parameter : blue
     */
    public func fadeToColour(r: Int, g: Int, b: Int, duration: Int) throws {
        if r > 255 || g > 255 || b > 255 || r < 0 || g < 0 || b < 0 {
            throw FixtureError.channelValueOutOfBounds
        }
        
        do { try fadeToValue(channel: ChannelType.Red, value: r, duration: duration) } catch {print("fade err")}
        do { try fadeToValue(channel: ChannelType.Green, value: g, duration: duration) } catch {print("fade err")}
        do { try fadeToValue(channel: ChannelType.Blue, value: b, duration: duration) } catch {print("fade err")}
    }
    
    override func send() -> [UInt8] {
        return [UInt8(getIntensity()),
                UInt8(getRed()),
                UInt8(getGreen()),
                UInt8(getBlue()),
                UInt8(getStrobe())]
    }
}
