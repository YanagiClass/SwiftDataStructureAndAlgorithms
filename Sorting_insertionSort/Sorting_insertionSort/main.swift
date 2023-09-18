//
//  main.swift
//  Sorting_insertionSort
//
//  Created by 유용상 on 2023/09/18.
//

import Foundation




func insertionSort<T: Comparable>(_ array: [T]) -> [T] {
    guard array.count > 1 else { return array }

    var sortedArray = array
    for var index in 1..<sortedArray.count {
        let temp = sortedArray[index]
        while index > 0, temp < sortedArray[index - 1] {
            sortedArray[index] = sortedArray[index - 1]
            index -= 1
        }
        sortedArray[index] = temp
    }
    return sortedArray
}

var arr = [4, 2, 3, 1]
print(insertionSort(arr))
