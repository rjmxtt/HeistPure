//
//  Frasnel.swift
//  Heist1
//
//  Created by rjm on 17/12/2019.
//  Copyright © 2019 rjm. All rights reserved.
//

import Foundation

class Frasnel : Fixture {
    override init(startChannel: Int, totalChannel: Int) {
        super.init(startChannel: startChannel, totalChannel: totalChannel)
        super.setTypeTag(tag:TypeTag.Frasnel)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        let sC = try container.decode(Int.self, forKey: .startChannel)
        let tC = try container.decode(Int.self, forKey: .totalChannel)
        super.init(startChannel: sC, totalChannel: tC)
        super.setTypeTag(tag:TypeTag.Frasnel)
    }
}
