//
//  main.swift
//  Tree_BSTDeletion
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
extension Node {

    func minimumValueNode() -> Node {
        var current = self
        while let next = current.left {
            current = next
        }
        return current
    }
}

extension BinarySearchTree {
    
    func delete(_ value: T) {
        root = delete(from: root, value: value)
    }
    
    private func delete(from node: Node<T>?, value: T) -> Node<T>? {
        guard let node = node else {
            return nil
        }
        
        if value < node.value {
            node.left = delete(from: node.left, value: value)
        } else if value > node.value {
            node.right = delete(from: node.right, value: value)
        } else {

            if node.left == nil {
                return node.right
            } else if node.right == nil {
                return node.left
            }

            node.value = node.right!.minimumValueNode().value
            node.right = delete(from: node.right, value: node.value)
        }
        
        return node
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

// 사용 예시
let bst = BinarySearchTree<Int>()
bst.insert(50)
bst.insert(30)
bst.insert(20)
bst.insert(40)
bst.insert(70)
bst.insert(60)
bst.insert(80)

// 50을 삭제 (루트 노드이며, 두 자식을 가짐)
bst.delete(50)

// 30을 삭제 (하나의 자식만 가짐)
bst.delete(30)

// 60을 삭제 (잎 노드)
bst.delete(60)


