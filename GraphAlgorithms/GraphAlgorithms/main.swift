//
//  main.swift
//  GraphAlgorithms
//
//  Created by 유용상 on 2023/09/18.
//

import Foundation

//MARK: 최단경로

func dijkstra(graph: [[Int]], start: Int) -> [Int] {
    var distances = [Int](repeating: Int.max, count: graph.count)
    var visited = [Bool](repeating: false, count: graph.count)
    
    distances[start] = 0
    
    for _ in 0..<graph.count {
        let u = minDistance(distances, visited)
        visited[u] = true
        
        for v in 0..<graph.count {
            if !visited[v] && graph[u][v] != 0 && distances[u] != Int.max && distances[u] + graph[u][v] < distances[v] {
                distances[v] = distances[u] + graph[u][v]
            }
        }
    }
    
    return distances
}


func minDistance(_ dist: [Int], _ visited: [Bool]) -> Int {
    var min = Int.max, minIndex = 0
    
    for v in 0..<dist.count {
        if visited[v] == false && dist[v] <= min {
            min = dist[v]
            minIndex = v
        }
    }
    
    return minIndex
}

let graph1 = [
    [0, 1, 4, 0, 0],
    [0, 0, 2, 7, 0],
    [0, 0, 0, 5, 0],
    [0, 0, 0, 0, 1],
    [0, 0, 0, 0, 0]
]

let start1 = 0
let shortestPaths = dijkstra(graph: graph1, start: start1)
print("Dijkstra's Shortest Paths: \(shortestPaths)")


//MARK: 최장경로
func topologicalSort(graph: [[(Int, Int)]], start: Int, visited: inout [Bool], stack: inout [Int]) {
    visited[start] = true
    
    for (v, _) in graph[start] {
        if !visited[v] {
            topologicalSort(graph: graph, start: v, visited: &visited, stack: &stack)
        }
    }
    
    stack.append(start)
}

func findLongestPath(graph: [[(Int, Int)]], vertexCount: Int, start: Int) -> [Int] {
    var dist = [Int](repeating: Int.min, count: vertexCount)
    dist[start] = 0
    
    var visited = [Bool](repeating: false, count: vertexCount)
    var stack: [Int] = []
    

    for i in 0..<vertexCount {
        if !visited[i] {
            topologicalSort(graph: graph, start: i, visited: &visited, stack: &stack)
        }
    }
    

    let topologicalOrder = stack.reversed()
    
    for u in topologicalOrder {
        for (v, weight) in graph[u] {
            if dist[u] != Int.min && dist[u] + weight > dist[v] {
                dist[v] = dist[u] + weight
            }
        }
    }
    
    return dist
}

let graph2 = [
    [(1, 1), (2, 4)],
    [(2, 2)],
    [(3, 5)],
    [(4, 1)],
    []
]

let start2 = 0
let longestPaths = findLongestPath(graph: graph2, vertexCount: 5, start: start2)
print("Longest Paths in DAG: \(longestPaths)")


//MARK: DFS
var visited: [Bool] = []

func dfs(graph: [[Int]], start: Int) {
    visited[start] = true
    print(start)
    
    for v in graph[start] {
        if !visited[v] {
            dfs(graph: graph, start: v)
        }
    }
}
let graph3 = [
    [1, 2],
    [2],
    [0, 3],
    [3]
]

visited = Array(repeating: false, count: graph3.count)
print("DFS starting from vertex 0:")
dfs(graph: graph3, start: 0)


//MARK: BFS
func bfs(graph: [[Int]], start: Int) {
    var visited = [Bool](repeating: false, count: graph.count)
    var queue: [Int] = []
    
    visited[start] = true
    queue.append(start)
    
    while !queue.isEmpty {
        let u = queue.removeFirst()
        print(u)
        
        for v in graph[u] {
            if !visited[v] {
                visited[v] = true
                queue.append(v)
            }
        }
    }
}
let graph4 = [
    [1, 2],
    [2],
    [0, 3],
    [3]
]

print("BFS starting from vertex 0:")
bfs(graph: graph4, start: 0)

