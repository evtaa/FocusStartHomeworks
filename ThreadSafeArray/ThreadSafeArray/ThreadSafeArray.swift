//
//  ThreadSafeArray.swift
//  ThreadSafeArray
//
//  Created by Alexandr Evtodiy on 05.11.2021.
//

import Foundation

protocol ThreadSafeArrayProtocol {
    associatedtype Element
    var count: Int{ get }
    var isEmpty: Bool { get }
    func append( _ item: Element)
    func remove(at index: Int)
    subscript(index: Int) -> Element { get set }
}

public class ThreadSafeArray<Element>: ThreadSafeArrayProtocol {
    var queue = DispatchQueue(label: "evtaa.ThreadSafeArray",
                                       attributes: .concurrent)
    var array = [Element]()
}

// MARK: - Properties
public extension ThreadSafeArray {
    var count: Int {
        var result = 0
        queue.sync { result = self.array.count }
        return result
    }
    
    var isEmpty: Bool {
        var result = false
        queue.sync { result = self.array.isEmpty }
        return result
    }
}

// MARK: - Mutable functions
public extension ThreadSafeArray {
    func append( _ item: Element) {
        queue.async(flags: .barrier) {
            self.array.append(item)
        }
    }
    
    func remove(at index: Int) {
        queue.async(flags: .barrier) {
            guard self.array.startIndex..<self.array.endIndex ~= index
            else { return }
            self.array.remove(at: index)
        }
    }
}

// MARK: - Subscript
public extension ThreadSafeArray {
    subscript(index: Int) -> Element {
        get {
            var result: Element!
            queue.sync {
                guard self.array.startIndex..<self.array.endIndex ~= index
                else { return }
                result = self.array[index]
            }
            return result
        }
        set {
            queue.async(flags: .barrier) {
                guard self.array.startIndex..<self.array.endIndex ~= index
                else { return }
                self.array[index] = newValue
            }
        }
    }
}

public extension ThreadSafeArray where Element: Equatable {
    func contains(_ element: Element) -> Bool {
        var result = false
        queue.sync { result = self.array.contains(element) }
        return result
    }
}
