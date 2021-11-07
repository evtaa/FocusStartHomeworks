//
//  main.swift
//  ThreadSafeArray
//
//  Created by Alexandr Evtodiy on 05.11.2021.
//

import Foundation

typealias Type = Int
var array = ThreadSafeArray<Type>()
let group = DispatchGroup()
let myGlobalQueue = DispatchQueue.global()

func appendToArray(element: Type) {
    for _ in 0...1000 {
        array.append(element)
    }
}

myGlobalQueue.async(group: group) {
    appendToArray(element: 1)
}

myGlobalQueue.async(group: group) {
    appendToArray(element: 2)
}


group.notify(queue: myGlobalQueue) {
    print(array.count)
}

sleep(3)




