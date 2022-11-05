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
