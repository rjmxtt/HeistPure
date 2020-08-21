//
//  ListIO.swift
//  Heist2
//
//  Created by rjm on 09/03/2020.
//  Copyright © 2020 rjm. All rights reserved.
//

import Foundation

class ListIO : Codable {
    var id : Int?
    var description : String?
    var list : [NodeIO]?
    //let clo = Closures()
    
    init() {}
    
    enum Keys : String, CodingKey {
        case tagType
        case channel
        case value
        case step
    }
    
    func listExtract() -> LinkedList {
        let out = LinkedList()
        for elem in list! {
            out.addNode(newNode: elem.nodeExtract())
        }
        return out
    }
}
