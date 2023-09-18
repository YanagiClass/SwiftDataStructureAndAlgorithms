//
//  main.swift
//  Search_SequentialSearch
//
//  Created by 유용상 on 2023/09/18.
//

import Foundation



func sequentialSearch<T: Equatable>(_ array: [T], _ target: T) -> Int? {
    for (index, item) in array.enumerated() {
        if item == target {
            return index
        }
    }
    return nil
}

// 사용 예시
let myArray = [1, 2, 3, 4, 5, 6, 7, 8, 9]
if let index = sequentialSearch(myArray, 5) {
    print("Found at index \(index)")
} else {
    print("Not found")
}

if let index = sequentialSearch(myArray, 10) {
    print("Found at index \(index)")
} else {
    print("Not found")
}
