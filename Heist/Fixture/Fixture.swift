//
//  Fixture.swift
//  Heist1
//
//  Created by rjm on 16/12/2019.
//  Copyright © 2019 rjm. All rights reserved.
//

import Foundation

class Fixture : Codable {
    internal var startChannel : Int
    internal var totalChannel : Int
    internal var intensity : Int
    internal var disk : Int?
    internal var speed : Int?
    internal var red : Int?
    internal var green : Int?
    internal var blue : Int?
    internal var strobe : Int?
    internal var pan : Int?
    internal var tilt : Int?
    internal var pattern : Int?
    internal var typeTag : TypeTag?
    
    enum TypeTag: String, Codable {
        case Parcan = "parcan"
        case Frasnel = "frasnel"
        case Laser = "laser"
        case Gobo = "gobo"
        case Haze = "haze"
        case RotatingHead = "rotHead"
    }
    
    enum FixtureError : Error {
        case channelValueOutOfBounds
        case nonRelevantChannel
    }
    
    enum ChannelType : String, Codable{
        case Intensity = "intensity"
        case Disk = "disk"
        case Speed = "speed"
        case Red = "red"
        case Green = "green"
        case Blue = "blue"
        case Strobe = "strobe"
        case Pan = "pan"
        case Tilt = "tilt"
        case Pattern = "pattern"
    }
    
    enum Keys : String, CodingKey {
        case startChannel
        case totalChannel
    }
    
    init(startChannel : Int, totalChannel : Int) {
        self.startChannel = startChannel
        self.totalChannel = totalChannel
        intensity = 0
    }
    
    public func setTypeTag(tag:TypeTag) {
        typeTag = tag
    }
    
    public func getStartChannel() -> Int {
        return startChannel
    }
    
    public func setStartChannel(newStartChannel : Int) {
        self.startChannel = newStartChannel
    }
    
    public func getTotalChannel() -> Int {
        return totalChannel
    }
    
    public func setTotalChannel(newTotalChannel : Int) {
        self.totalChannel = newTotalChannel
    }
    
    public func getIntensity() -> Int {
        if intensity == -1 {
            return Int(AudioFile.sharedAudio.getAmp() * 255)
        } else {
            return intensity
        }
    }
    
    public func setIntensity(newIntensity : Int) throws {
        if newIntensity > 255 {
            throw FixtureError.channelValueOutOfBounds
        } else {
            self.intensity = newIntensity
        }
    }
    
    public func getChannelValue(channel: ChannelType) throws -> Int {
        switch channel {
        case .Intensity :
            return getIntensity()
        default:
            throw FixtureError.nonRelevantChannel
        }
    }
    
    /**
     Sets channel to value
     - Parameter : channel being changed
     - Parameter : new value of channel
     
     - throws : non relevent channel error
     */
    public func stepChannelToValue(channel: ChannelType, value: Int) throws {
        switch channel {
            case ChannelType.Intensity :
                intensity = value
            default:
                throw FixtureError.nonRelevantChannel
        }
    }
    
    /**
     fades value of channel over period of time
     
     - parameter : channel being changed
     - parameter : new value of channel
     - parameter : time period over which value is being changed
     */
    public func fadeToValue(channel: ChannelType, value: Int, duration: Int) throws {
        let steps = duration / 100
        let interval = duration / steps
        let incr  = value / steps
        
        var newValue = 0
        do { try newValue = getChannelValue(channel: channel)} catch {print("oioi") }
        
        for _ in 1...steps {
            newValue += incr
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(interval)) {
                do { try self.stepChannelToValue(channel: channel, value: newValue) }
                catch { return }
            }
        }
    }
    
    public func getFadeToValue(channel: ChannelType, value: Int, duration: Int) -> () throws -> () {
        return {
            let steps = duration / 100
            let interval = duration / steps
            let incr  = value / steps
            
            var newValue = 0
            do { try newValue = self.getChannelValue(channel: channel)} catch {print("oioi") }
            
            for _ in 1...steps {
                newValue += incr
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(interval)) {
                    do { try self.stepChannelToValue(channel: channel, value: newValue) }
                    catch { return }
                }
            }
        }
    }
    
    /**
     fades channel to value and back to zero over time period
     
     - parameter : channel being changed
     - parameter : max value of change
     - parameter : time period over which value is being changed
     */
    public func pulseOnBeat(channel: ChannelType, value: Int, duration: Int) {
        do { try self.fadeToValue(channel: channel, value: value, duration: duration/2) } catch { print ("err") }
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(duration/2)) {
            do { try self.fadeToValue(channel: channel, value: 0, duration: duration/2) } catch { print ("err") }
        }
    }
    
    /**
     Flashes channel to maximum value for one DMX time period
     
     - parameter : channel being flashed 
     */
    public func flash(channel: ChannelType) throws {
        do { try self.stepChannelToValue(channel: channel, value: 255) }
            catch {print ("error must be hadled before method call")}
        print (getIntensity())
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(40)) {
            do { try self.stepChannelToValue(channel: channel, value: 0) }
                catch {print ("error must be hadled before method call")}
        }
    }
    
    public func getFlash(channelC: ChannelType) -> () throws -> () {
        return {
            do { try self.stepChannelToValue(channel: channelC, value: 255) }
                catch {print ("error must be hadled before method call")}
            print (self.getIntensity())
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(40)) {
                do { try self.stepChannelToValue(channel: channelC, value: 0) }
                    catch {print ("error must be hadled before method call")}
            }
        }
    }
    
    public func send() -> [UInt8] {
        return [UInt8(getIntensity())]
    }
    
    public func toString() -> String {
        let ret = "Channel: " + String(startChannel)
        return ret
    }
}

