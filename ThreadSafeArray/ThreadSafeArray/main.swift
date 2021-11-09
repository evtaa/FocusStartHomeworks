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
let myGlobalQueue = DispatchQueue(label: "evtaa.someNameForQueue", qos: .userInitiated, attributes: .concurrent)

func appendToThreadSafeArray<T>(element: T, array: inout ThreadSafeArray<T>) {
    for _ in 0...1000 {
        array.append(element)
    }
}

myGlobalQueue.async(group: group) {
    appendToThreadSafeArray(element: 1, array: &array)
}

myGlobalQueue.async(group: group) {
    appendToThreadSafeArray(element: 2, array: &array)
}

group.notify(queue: myGlobalQueue) {
    print(array.count)
    
}

sleep(3)





