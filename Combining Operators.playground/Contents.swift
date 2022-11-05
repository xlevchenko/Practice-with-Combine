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


example(of: "prepend(Publisher)") {
    let publisher1 = [3, 4].publisher
    let publisher2 = [1, 2].publisher
    
    publisher1
        .prepend(publisher2)
        .sink(receiveValue: { print($0) })
        .store(in: &subscriptions)
}


example(of: "prepend(Publisher) #2") {
    let publisher1 = [3, 4].publisher
    let publisher2 = PassthroughSubject<Int, Never>()
    
    publisher1
        .prepend(publisher2)
        .sink(receiveValue: { print($0) })
        .store(in: &subscriptions)
    
    publisher2.send(1)
    publisher2.send(2)
    publisher2.send(completion: .finished)
}
