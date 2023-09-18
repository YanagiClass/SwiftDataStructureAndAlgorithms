//
//  main.swift
//  Sorting_BucketSort
//
//  Created by 유용상 on 2023/09/18.
//

import Foundation

public func bucketSort<T>(_ elements: [T], distributor: Distributor, sorter: Sorter, buckets: [Bucket<T>]) -> [T] {
    precondition(allPositiveNumbers(elements))
    precondition(enoughSpaceInBuckets(buckets, elements: elements))

    var bucketsCopy = buckets
    for elem in elements {
        distributor.distribute(elem, buckets: &bucketsCopy)
    }

    var results = [T]()

    for bucket in bucketsCopy {
        results += bucket.sort(sorter)
    }

    return results
}

private func allPositiveNumbers<T: Sortable>(_ array: [T]) -> Bool {
    return array.filter { $0.toInt() >= 0 }.count > 0
}

private func enoughSpaceInBuckets<T>(_ buckets: [Bucket<T>], elements: [T]) -> Bool {
    let maximumValue = elements.max()?.toInt()
    let totalCapacity = buckets.count * (buckets.first?.capacity)!

    guard let max = maximumValue else {
        return false
    }
    
    return totalCapacity >= max
}



public protocol Distributor {
    func distribute<T>(_ element: T, buckets: inout [Bucket<T>])
}


public struct RangeDistributor: Distributor {

    public init() {}

    public func distribute<T>(_ element: T, buckets: inout [Bucket<T>]) {
        let value = element.toInt()
        let bucketCapacity = buckets.first!.capacity

        let bucketIndex = value / bucketCapacity
        buckets[bucketIndex].add(element)
    }
}



public protocol IntConvertible {
    func toInt() -> Int
}

public protocol Sortable: IntConvertible, Comparable {
}



public protocol Sorter {
    func sort<T: Sortable>(_ items: [T]) -> [T]
}

public struct InsertionSorter: Sorter {

    public init() {}

    public func sort<T: Sortable>(_ items: [T]) -> [T] {
        var results = items
        for i in 0 ..< results.count {
            var j = i
            while j > 0 && results[j-1] > results[j] {

                let auxiliar = results[j-1]
                results[j-1] = results[j]
                results[j] = auxiliar

                j -= 1
            }
        }
        return results
    }
}



public struct Bucket<T: Sortable> {
    var elements: [T]
    let capacity: Int

    public init(capacity: Int) {
        self.capacity = capacity
        elements = [T]()
    }

    public mutating func add(_ item: T) {
        if elements.count < capacity {
            elements.append(item)
        }
    }

    public func sort(_ algorithm: Sorter) -> [T] {
        return algorithm.sort(elements)
    }
}

//사용예시
// 만약 Int 타입을 정렬한다면, Int를 Sortable로 만들어 줍니다.
extension Int: Sortable, IntConvertible {
    public func toInt() -> Int {
        return self
    }
}

// Distributor와 Sorter를 생성합니다.
let myDistributor = RangeDistributor()
let mySorter = InsertionSorter()

// 버킷을 생성합니다. 여기서는 0부터 99까지의 수를 정렬하기 위해 10개의 버킷을 생성합니다.
var myBuckets = [Bucket<Int>]()
for _ in 0..<10 {
    myBuckets.append(Bucket(capacity: 10))
}

// 정렬할 배열을 준비합니다.
let unsortedArray = [34, 7, 23, 32, 5, 62]

// 버킷 정렬을 실행합니다.
let sortedArray = bucketSort(unsortedArray, distributor: myDistributor, sorter: mySorter, buckets: myBuckets)

//출력
print(sortedArray)
