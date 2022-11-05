import UIKit
import Combine

var subscriptions = Set<AnyCancellable>()

example(of: "prepend(Output...)") {
    let publisher = [3, 4].publisher
    
    publisher
        .prepend(1, 2)
        .prepend(-5, 8)
        .sink(receiveValue: { print($0) })
        .store(in: &subscriptions)
}


example(of: "prepend(Sequence)") {
    let publisher = [5, 6, 7].publisher
    
    publisher
        .prepend([3, 4])
        .prepend(stride(from: 6, to: 11, by: 2))
        .prepend(Set(1...2))
        .sink(receiveValue: { print($0) })
        .store(in: &subscriptions)
}
