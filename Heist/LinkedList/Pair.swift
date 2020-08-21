//
//  Pair.swift
//  Heist1
//
//  Created by rjm on 19/12/2019.
//  Copyright © 2019 rjm. All rights reserved.
//

import Foundation

public class Pair {
    var fst : Tag
    var snd : Int
    
    init(fst: Tag, snd: Int) {
        self.fst=fst
        self.snd=snd
    }
    
    func toString() -> String {
        return "( \"\(fst)\" , \"\(snd)\" )"
    }
    

}
