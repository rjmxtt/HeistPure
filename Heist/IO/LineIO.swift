//
//  Line.swift
//  Heist2
//
//  Created by rjm on 09/03/2020.
//  Copyright © 2020 rjm. All rights reserved.
//

import Foundation

class LineIO : NodeIO {
    var tagType : Fixture.TypeTag
    var channel : Fixture.ChannelType
    var value : Int
    
    init(tagType:Fixture.TypeTag , channel:Fixture.ChannelType , value:Int) {
        self.tagType = tagType
        self.channel = channel
        self.value = value
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        let tT = try container.decode(Fixture.TypeTag.self, forKey: .tagType)
        let cT = try container.decode(Fixture.ChannelType.self, forKey: .channel)
        let cV = try container.decode(Int.self, forKey: .value)
        self.tagType = tT
        self.channel = cT
        self.value = cV
        super.init()
    }
    
    func lineExtract() -> (Fixture) throws -> () {
        let clo = Closures()
        return clo.getStepToValue(typeTag: self.tagType, channel: self.channel, value: self.value)
    }
}
