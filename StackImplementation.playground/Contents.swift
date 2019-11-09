import UIKit

protocol StackType {
    associatedtype T
    var top: Int { get }
    mutating func push(item: T) throws
    mutating func pop() throws
    func peek() throws -> T?
}

enum StackError: Error {
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

struct Stack<Item>: StackType {
    typealias T = Item
    
    private var items: [Item]
    private var size: Int = 0
    
    init(stackSize: Int) {
        size = stackSize
        items = [Item]()
    }
    
    var top: Int {
        return items.count
    }
    
    mutating func push(item: Item) throws {
        if items.count == size {
            throw StackError.overflow
        }
        items.append(item)
        print("Pushed \(item) in stack")
    }
    
    mutating func pop() throws {
        if items.isEmpty {
            throw StackError.underflow
        }
        print("Popping \(items.last!) in stack")
        items.removeLast()
    }
    
    func peek() throws -> Item? {
        if items.isEmpty {
            throw StackError.underflow
        }
        return items.last
    }
}

// Implementations

var stack = Stack<Int>(stackSize: 4)

do {
    for i in 1...8 {
        try stack.push(item: i)
    }
} catch let e as StackError {
    print(e.description)
}

stack.top

do {
    try stack.peek()
    try stack.pop()
    try stack.pop()
    try stack.pop()
} catch let e as StackError {
    print(e.description)
}

