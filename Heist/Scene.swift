
//
//  Scene.swift
//  Heist1
//
//  Created by rjm on 09/12/2019.
//  Copyright © 2019 rjm. All rights reserved.
//

import Foundation


class Scene {
    private let sceneID : Int
    private var description = ""
    var pointer : Node?
    var instructions: LinkedList
    var package : [UInt8]
    private var sceneZeros : [UInt8]
    internal var fixtureArray : [Fixture]
    
    init(sceneID: Int) {
        self.sceneID = sceneID
        instructions = LinkedList()
        fixtureArray = []
        pointer = nil
        package = Array(repeating: 0, count: 512)
        sceneZeros = [UInt8](repeating: 0, count: 10)
    }
    
    func constructFixArr(from: Fixtures) {
        let loadedArray = from.giveArray()
        if loadedArray.count > 0 {
            fixtureArray = loadedArray
        } else {
            print("Loaded Array Empty")
        }
    }
    
    public func getID() -> Int {
        return sceneID 
    }
    
    public func setDescription(dscr:String) {
        description = dscr
    }
    
    public func getDescription() -> String {
        return description
    }
    
    func addToFixtureArray(fix:Fixture) {
        fixtureArray.append(fix)
    }
    
    func getFixtureArray() -> [Fixture] {
        return fixtureArray
    }
    
    func getInstructions() -> LinkedList {
        return instructions
    }
    
    func addInstructionArr(toAdd: [(Fixture)throws->Void]) {
        instructions.add(value:toAdd)
        if instructions.getSize() == 1 {
            pointer = instructions.first
        }
    }
    
    /**
      Adds function to instruction list
     
     - parameter : instruction to be added of type (Int)->Void
     */
    func addInstruction(instruction: @escaping (Fixture)throws->Void) {
        instructions.add(value: [instruction])
        if instructions.getSize() == 1 {
            pointer = instructions.first
        }
    }
    
    /**
     Function providing incrementer function
     
    parameter : ammout to increment
    parameter : tag of channels to increment
     */
    func incrB(toAdd:Int, cond: Tag) -> (Pair) -> Void {
        return {
            (num:Pair) -> Void in
                if num.fst == cond {
                    num.snd = (num.snd+toAdd) }
        }
    }
    
    func step() {
        let arr = pointer!.value
        for instruction in arr {
            do { try self.fixtureArray.map(instruction) } catch { print ("step err") }
        }
        pointer = pointer!.next
        //return send()
    }

    func send() -> [UInt8] {
        var i = 0
        for fix in fixtureArray {
            let arr = fix.send()
            for j in 0 ... (arr.count - 1) {
                package[i] = arr[j]
                i+=1
            }
        }
        return package
    }
    
    //this is an embarasing way of doing this but leave it for now
    func primeScene() {
        if pointer == nil {
            pointer = instructions.head
        }
    }
}

