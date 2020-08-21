//
//  LinkedList.swift
//  Heist1
//
//  Copyright © 2016 Chris Pilcher. All rights reserved.
//

import Foundation

public class LinkedList {
    internal var head: Node?
    private var tail: Node?
    private var size: Int = 0

    public var isEmpty: Bool {
        return head == nil
    }

    public var first: Node? {
        return head
    }

    public var last: Node? {
        return tail
    }
    
    public func getSize() -> Int {
        return size;
    }
    
    internal func addNode(newNode: Node) {
        if let tailNode = tail {
          newNode.previous = tailNode
          newNode.next = head
          tailNode.next = newNode
        } else {
          head = newNode
        }
        tail = newNode
        size+=1
    }
    
    internal func add(value: [(Fixture)throws->Void]) {
      let newNode = Node(value: value)
      if let tailNode = tail {
        newNode.previous = tailNode
        newNode.next = head
        tailNode.next = newNode
      } else {
        head = newNode
      }
      tail = newNode
      size+=1
    }
    
    public func nodeAt(index: Int) -> Node? {
      if index >= 0 {
        var node = head
        var i = index
        while node != nil {
          if i == 0 { return node }
          i -= 1
          node = node!.next
        }
      }
      return nil
    }
    
    internal func remove(node: Node) -> [(Fixture)throws->Void]  {
      let prev = node.previous
      let next = node.next

      if let prev = prev {
        prev.next = next
      } else {
        head = next
      }
      next?.previous = prev
      if next == nil {
        tail = prev
        prev?.next = head
      }

      node.previous = nil
      node.next = nil

      size-=1
        
      return node.value
    }
    
}

