import UIKit

protocol QueueType {
    associatedtype T
    var rear: Int { get }
    mutating func enqueue(item: T) throws
    mutating func dequeue() throws
    func front() throws -> T?
}

enum QueueError: Error {
    case overflow
    case underflow
    
    var description: String {
        get {
            switch self {
            case .overflow:
                return "***** STACK OVERFLOW *****"
            case .underflow:
                return "***** STACK UNDERFLOW *****"
            }
        }
    }
}

struct Queue<Item>: QueueType {
    typealias T = Item
    
    private let size: Int
    private var items = [Item]()
    
    init(size: Int) {
        self.size = size
    }
    
    var rear: Int {
        return items.count
    }
    
    var description: String {
        let contents = Array(items.reversed())
        return """
        ------- QUEUE -------
        \(contents)
        ---------------------
        """
    }
    
    mutating func enqueue(item: Item) throws {
        if items.count == size {
            throw QueueError.overflow
        } else {
            items.append(item)
            print("Enqueued \(item) in queue")
        }
    }
    
    mutating func dequeue() throws {
        if items.isEmpty {
            throw QueueError.underflow
        } else {
            print("Dequeuing \(items[0]) from queue")
            items.remove(at: 0)
        }
    }
    
    func front() throws -> Item? {
        if items.isEmpty {
            throw QueueError.underflow
        }
        return items[0]
    }

}

var queue = Queue<Int>(size: 4)

do {
    try queue.enqueue(item: 2)
    try queue.enqueue(item: 5)
    try queue.enqueue(item: 1)
    try queue.enqueue(item: 4)
    try queue.enqueue(item: 3)
//    try queue.dequeue()
//    try queue.dequeue()
} catch let e as QueueError {
    print(e.description)
    print(queue.description)
}

do {
    try queue.dequeue()
//    try queue.dequeue()
} catch let e as QueueError {
    print(e.description)
}

print(queue.description)
print(try! queue.front())
