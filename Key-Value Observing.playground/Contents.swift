import UIKit
import Combine
import Foundation

let queue = OperationQueue()

//let subcription = queue.publisher(for: \.operationCount)
//    .sink {
//        print("Outstanding operations in queue: \($0)")
//    }
struct PureSwift {
    let a: (Int, Bool)
}


class TestObject: NSObject {
    @objc dynamic var integerProperty: Int = 0
    @objc dynamic var stringProperty: String = ""
    @objc dynamic var arrayProperty: [Float] = []
    //@objc dynamic var structPropety: PureSwift = .init(a: (0, false)) //error
}

let obj = TestObject()

let subscription = obj.publisher(for: \.integerProperty)
    .sink {
        print("integerProperty changes to \($0)")
    }

let subscription2 = obj.publisher(for: \.stringProperty)
    .sink {
        print("stringProperty changes to \($0)")
    }

let subscription3 = obj.publisher(for: \.arrayProperty)
    .sink {
        print("arrayProperty changes to \($0)")
    }

obj.integerProperty = 100
obj.integerProperty = 200
obj.stringProperty = "Hello"
obj.arrayProperty = [1.0]
obj.stringProperty = "World"
obj.arrayProperty = [1.0, 2.0]


class MonitorObject: ObservableObject {
    @Published var someProperty = false
    @Published var someOtherProperty = ""
}

let object = MonitorObject()
let subscription4 = object.objectWillChange.sink {
    print("object will change")
}

object.someProperty = true
object.someOtherProperty = "Hello world"
