//
//  Fixtures.swift
//  Heist1
//
//  Created by rjm on 18/02/2020.
//  Copyright © 2020 rjm. All rights reserved.
//

import Foundation

struct Fixtures: Codable {
    
//    var type: String
//    var fix: [Fixture]
    
    var gobos : [Gobo]?
    var fras : [Frasnel]?
    var hazes : [Haze]?
    var pars : [Parcan]?
    var rotHeads : [RotatingHead]?
    var lasers : [Laser]?
    
    func giveArray() -> [Fixture] {
        var out : [Fixture] = []
        out += gobos ?? []
        out += fras ?? []
        out += hazes ?? []
        out += pars ?? []
        out += rotHeads ?? []
        out += lasers ?? []
        return out
    }
}
