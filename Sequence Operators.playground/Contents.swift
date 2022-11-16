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

