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

func appendToThreadSafeArray<T>(element: T) {
    for _ in 0...1000 {
        guard let element = element as? Type
        else {return}
        array.append(element)
    }
}

myGlobalQueue.async(group: group) {
    appendToThreadSafeArray(element: 1)
}

myGlobalQueue.async(group: group) {
    appendToThreadSafeArray(element: 2)
}

group.notify(queue: myGlobalQueue) {
    print(array.count)
    
}

sleep(3)





