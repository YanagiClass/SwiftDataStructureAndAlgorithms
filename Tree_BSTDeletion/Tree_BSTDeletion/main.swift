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



extension BinarySearchTree {
    
    // (10) In-order Traversal
    func inOrderTraversal(from node: Node<T>?, visit: (T) -> Void) {
        guard let node = node else { return }
        
        inOrderTraversal(from: node.left, visit: visit)
        visit(node.value)
        inOrderTraversal(from: node.right, visit: visit)
    }
    
    // (11) Pre-order Traversal
    func preOrderTraversal(from node: Node<T>?, visit: (T) -> Void) {
        guard let node = node else { return }
        
        visit(node.value)
        preOrderTraversal(from: node.left, visit: visit)
        preOrderTraversal(from: node.right, visit: visit)
    }
    
    // (12) Post-order Traversal
    func postOrderTraversal(from node: Node<T>?, visit: (T) -> Void) {
        guard let node = node else { return }
        
        postOrderTraversal(from: node.left, visit: visit)
        postOrderTraversal(from: node.right, visit: visit)
        visit(node.value)
    }
}

// 사용 예시
let bst = BinarySearchTree<Int>()
bst.insert(5)
bst.insert(2)
bst.insert(8)
bst.insert(1)
bst.insert(3)

print("In-order Traversal:")
bst.inOrderTraversal(from: bst.root) { print($0) }  // 출력: 1 2 3 5 8

print("Pre-order Traversal:")
bst.preOrderTraversal(from: bst.root) { print($0) }  // 출력: 5 2 1 3 8

print("Post-order Traversal:")
bst.postOrderTraversal(from: bst.root) { print($0) }  // 출력: 1 3 2 8 5
