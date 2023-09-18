//
//  main.swift
//  Tree_BSTInsertion
//
//  Created by 유용상 on 2023/09/18.
//

import Foundation

class Node<T: Comparable> {
    var value: T
    var left: Node?
    var right: Node?
    
    init(_ value: T) {
        self.value = value
    }
}

class BinarySearchTree<T: Comparable> {
    var root: Node<T>?
    
    func insert(_ value: T) {
        root = insert(from: root, value: value)
    }
    
    private func insert(from node: Node<T>?, value: T) -> Node<T> {
        // 1. Base Case: 노드가 없는 경우 새 노드를 생성하여 반환
        guard let node = node else {
            return Node(value)
        }
        
        // 2. 재귀적 삽입
        if value < node.value {
            node.left = insert(from: node.left, value: value)
        } else if value > node.value {
            node.right = insert(from: node.right, value: value)
        }
        
        // 3. 노드 반환 (변경이 없다면 원래 노드)
        return node
    }
}

let bst = BinarySearchTree<Int>()
bst.insert(5)
bst.insert(2)
bst.insert(8)
bst.insert(1)
bst.insert(3)

