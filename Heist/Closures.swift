//
//  Closures.swift
//  Heist1
//
//  Created by rjm on 16/01/2020.
//  Copyright © 2020 rjm. All rights reserved.
//

import Foundation

public class Closures : Codable {
    
    init() {} 
    
    internal func getStepToValue(typeTag: Fixture.TypeTag, channel: Fixture.ChannelType, value: Int) ->
            (Fixture) throws -> () {
        return {
            (fix:Fixture) -> () in
            if typeTag == fix.typeTag {
                switch channel {
                    case Fixture.ChannelType.Intensity :
                        fix.intensity = value
                    case Fixture.ChannelType.Disk :
                        fix.disk = value
                    case Fixture.ChannelType.Speed :
                        fix.speed = value
                    case Fixture.ChannelType.Red :
                        fix.red = value
                    case Fixture.ChannelType.Green :
                        fix.green = value
                    case Fixture.ChannelType.Blue :
                        fix.blue = value
                    case Fixture.ChannelType.Strobe :
                        fix.strobe = value
                    case Fixture.ChannelType.Pan :
                        fix.pan = value
                    case Fixture.ChannelType.Tilt :
                        fix.tilt = value
                    case Fixture.ChannelType.Pattern :
                        fix.pattern = value
                }
            }
        }
    }
}
