import UIKit

var str = "Hello, playground"

// 1.Difference with FlapMap and CompactMap

let optional: Int? = 1
let a = [1, 2, nil]
let b = [[1, 2, 3], [4, 5, 6, 7, 8]]

optional.flatMap{ $0 }

let c1 = a.compactMap{ $0 }
let c2 = b.flatMap{ $0 }

print(c1)
print(c2)


// 2.Implementation: 1 + 2 * 3
// The answer is from: https://weibo.com/onevcat


typealias Op = (Int, Int) -> Int
indirect enum Node {
    case value(Int)
    case op(Op, Node, Node)
    
    func evaluate() -> Int {
        switch self {
        case .value(let v): return v
        case .op(let op, let left, let right): return op(left.evaluate(), right.evaluate())
        }
    }
}

extension Node: ExpressibleByIntegerLiteral {
    init(integerLiteral value: IntegerLiteralType) { self = .value(value) }
}

let root: Node = .op(+, 1, .op(*, 2, 3))
root.evaluate()

// For in

// before
let subviews: [UIView] = []
for view in subviews {
    if let button = view as? UIButton {
        button.setImage(nil, for: .normal)
    }
}
// after
for case let button as UIButton in subviews {
    button.setImage(nil, for: .normal)
}

// 3.ExpressibleByStringLiteral

struct Person: ExpressibleByStringLiteral {
    init(stringLiteral value: String) {
        name = value
    }
    let name: String
}

let ana: Person = "Ana"

// 4.ExpressibleByArrayLiteral

struct Stack<T> {
    private var array = [T]()
    
    func peek() -> T? {
        array.last
    }
    
    mutating func pop() -> T? {
        array.popLast()
    }
    
    mutating func push(_ element: T) {
        array.append(element)
    }
}

extension Stack: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: T...) {
        self.init(from: elements)
    }
}

var stack: Stack = [1, 2, 3, 4]
