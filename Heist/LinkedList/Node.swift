//
//  Node.swift
//  Heist1
//
//  Copyright © 2016 Chris Pilcher. All rights reserved.
//

import Foundation

public class Node {
    var value: [(Fixture) throws -> Void]
    var next: Node?
    weak var previous: Node?
     
    init(value: @escaping (Fixture) throws -> Void) {
      self.value = [value]
    }
    
    init(value: [(Fixture) throws -> Void]) {
      self.value = value
    }
    
    func addInstruction(toAdd: @escaping (Fixture) throws -> Void) {
        value.append(toAdd)
    }
}
