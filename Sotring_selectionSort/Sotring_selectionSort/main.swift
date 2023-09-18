//
//  main.swift
//  Sotring_selectionSort
//
//  Created by 유용상 on 2023/09/18.
//

import Foundation

public func selectionSort<T: Comparable>(_ array: [T], _ isOrderedBefore: (T, T) -> Bool) -> [T] {
    guard array.count > 1 else { return array }

    var a = array
    for x in 0 ..< a.count - 1 {

        
        var lowest = x
        for y in x + 1 ..< a.count {
            if isOrderedBefore(a[y], a[lowest]) {
                lowest = y
            }
        }

        
        if x != lowest {
            a.swapAt(x, lowest)
        }
    }
    return a
}

let sortedArray = selectionSort([3, 1, 4, 1, 5, 9, 2, 6, 5]) { (a, b) -> Bool in

    return a < b
}
print(sortedArray)
