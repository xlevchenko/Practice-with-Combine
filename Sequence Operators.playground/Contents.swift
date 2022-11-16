import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()

example(of: "min") {
    let publisher = [1, -50, 246, 0].publisher
    
    publisher
        .print("publisher")
        .min()
        .sink(receiveValue: { print("Lowets value is: \($0)") })
        .store(in: &subscriptions)
}

example(of: "min non-Comparable") {
    let publisher = ["12345", "ab", "hello world"]
    
        .map { Data($0.utf8) }
        .publisher
    
    publisher
        .print("publisher")
        .min(by: { $0.count < $1.count})
        .sink { data in
            let string = String(data: data, encoding: .utf8)!
            print("Smallets data is: \(string), \(data.count) bytes")
        }
        .store(in: &subscriptions)
}

