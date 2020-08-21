//
//  SceneIO.swift
//  Heist
//
//  Created by rjm on 28/03/2020.
//  Copyright © 2020 rjm. All rights reserved.
//

import Foundation

class ShowIO {
    var fixArr = Array<Fixture>()
    var instArr = Array<LinkedList>()
    
    init(){}
    
    //at some point this will be a 'show' object
    func extractShow() -> [Scene] {
        let fixIO = FixturesIO()
        let cloIO = ClosureIO()

        fixArr = (fixIO.read()?.giveArray())!
        instArr = (cloIO.read()?.extractLists())!
//        let sceneIO = cloIO.read()
//        print("woi \(sceneIO)")
//        instArr = (sceneIO?.extractLists())!
        
        var rtn = Array<Scene>()
        
        var i = 0
        for list in instArr {
            let new = Scene(sceneID: i)
            new.instructions = list
            new.fixtureArray = fixArr
            
            rtn.append(new)
            i+=1
        }
        
        return rtn
    }
}
