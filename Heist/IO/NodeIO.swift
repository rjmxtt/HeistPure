//
//  NodeIO.swift
//  Heist2
//
//  Created by rjm on 09/03/2020.
//  Copyright © 2020 rjm. All rights reserved.
//

import Foundation

class NodeIO : ListIO {
    var step : [LineIO]?

    override init() {super.init()}
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        step = try container.decode([LineIO].self, forKey: .step)
        super.init()
    }
    
    func nodeExtract() -> Node{
        var out = Array<((Fixture)throws->())>()
        for elem in step! {
            out.append(elem.lineExtract())
        }
        return Node(value: out)
    }
}
