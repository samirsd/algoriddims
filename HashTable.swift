//run this in a swift playground

import UIKit

var dictionary: [String: String] = [:]

dictionary["firstName"] = "Steve"

public struct HashTable<Key: Hashable, Value> {
    private typealias Element = (key: Key, value: Value)
    private typealias Bucket = [Element]
    private var buckets: [Bucket]
    
    private(set) public var count = 0
    public var isEmpty: Bool {
        return count == 0
    }
    
    public init(capacity: Int) {
        assert(capacity > 0)
        buckets = Array<Bucket>(repeating: [], count: capacity)
    }
    
    private func index(for key: Key) -> Int {
        return abs(key.hashValue) % buckets.count
    }
    
    public subscript(key: Key) -> Value? {
        get {
            return value(for: key)
        }
        set {
            if let value = newValue {
                update(value: value, for: key)
            }
        }
    }
    
    public func value(for key: Key) -> Value? {
        let index = self.index(for: key)
        return buckets[index].first { $0.key == key }?.value
    }
    
    @discardableResult
    public mutating func update(value: Value, for key: Key) -> Value? {
        let index = self.index(for: key)
        if let (i, element) = buckets[index].enumerated().first(where:
            { $0.1.key == key })
        {
            let oldValue = element.value
            buckets[index][i].value = value
            return oldValue
        }
        buckets[index].append((key: key, value: value))
        count += 1
        return nil
        
    }
}

let p = dictionary["firstName"]

print(p)

//hash table is an array. initially the arrry is empty. when u put a val into the hash table under a certain KEY it uses that key to calculate an index in the array. here is example:


dictionary["hobbies"] = "programming swift"



func naiveHash(_ string: String) -> Int {
    let unicodeScalars = string.unicodeScalars.map { Int($0.value) }
    return unicodeScalars.reduce(0, + )
}

func djb2Hash(_ string: String) -> Int {
    let unicodeScalars = string.unicodeScalars.map { $0.value }
    return unicodeScalars.reduce(5381) {
        ($0 << 5) &+ $0 &+ Int($1)
    }
}



naiveHash("abc")
djb2Hash("abc") // outputs 193485963
djb2Hash("bca") 

djb2Hash("firstName")

djb2Hash("firstName") % 2 // outputs 1
djb2Hash("lastName") % 2 // outputs 1

//let x = hashTable["lastName"]

var hashTable = HashTable<String, String>(capacity: 5)
