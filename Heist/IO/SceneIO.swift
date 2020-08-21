//
//  SceneIO.swift
//  Heist
//
//  Created by rjm on 27/03/2020.
//  Copyright © 2020 rjm. All rights reserved.
//

import Foundation

//this class is poorly names -> instructionsIO
class SceneIO : Codable {
    let lists: [ListIO]
    
    enum Keys : String, CodingKey  {
        case lists
    }
    
    init(id:Int, desc:String, lists:[LineIO]) {
        print("invalid use of SceneIO")
        self.lists = lists
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        let lists = try container.decode([ListIO].self, forKey: .lists)
        self.lists = lists
    }
    
    func extractLists() -> [LinkedList] {
        var rtn = Array<LinkedList>()
        for list in lists {
            rtn.append(list.listExtract())
        }
        return rtn
    }
}
