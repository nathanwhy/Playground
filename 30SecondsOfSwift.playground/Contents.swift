import UIKit

var str = "Hello, playground"

// Difference with FlapMap and CompactMap

let optional: Int? = 1
let a = [1, 2, nil]
let b = [[1, 2, 3], [4, 5, 6, 7, 8]]

optional.flatMap{ $0 }

let c1 = a.compactMap{ $0 }
let c2 = b.flatMap{ $0 }

print(c1)
print(c2)


// Implementation: 1 + 2 * 3
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



