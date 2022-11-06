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


example(of: "append(Output...)") {
    let publisher = [1].publisher
    
    publisher
        .append(2, 3)
        .append(4)
        .sink(receiveValue: { print($0) })
        .store(in: &subscriptions)
}


example(of: "appernd(Output...) #2") {
    let publisher = PassthroughSubject<Int, Never>()
    
    publisher
        .append(2, 3)
        .append(4)
        .sink(receiveValue: { print($0) })
        .store(in: &subscriptions)
    
    publisher.send(1)
    publisher.send(2)
    publisher.send(completion: .finished)
}


example(of: "append(Sequence)") {
    let publisher = [1, 2, 3].publisher
    
    publisher
        .append([4, 5])
        .append(Set([6, 7]))
        .append(stride(from: 8, to: 11, by: 2))
        .sink(receiveValue: { print($0) })
        .store(in: &subscriptions)
}


example(of: "append(Publisher)") {
    let publisher1 = [1, 2].publisher
    let publisher2 = [3, 4].publisher
    
    publisher1
        .append(publisher2)
        .sink(receiveValue: { print($0) })
        .store(in: &subscriptions)
}


example(of: "switchToLatest") {
    let publisher1 = PassthroughSubject<Int, Never>()
    let publisher2 = PassthroughSubject<Int, Never>()
    let publisher3 = PassthroughSubject<Int, Never>()
    
    let publisher = PassthroughSubject<PassthroughSubject<Int, Never>, Never>()
    
    publisher
        .switchToLatest()
        .sink(receiveCompletion: { _ in print("Completed") },
              receiveValue: { print($0) })
        .store(in: &subscriptions)
    
    publisher.send(publisher1)
    publisher1.send(1)
    publisher1.send(2)
    
    publisher.send(publisher2)
    publisher1.send(3)
    publisher2.send(4)
    publisher2.send(5)
    
    publisher.send(publisher3)
    publisher2.send(6)
    publisher3.send(7)
    publisher3.send(8)
    publisher3.send(9)
    
    publisher3.send(completion: .finished)
    publisher.send(completion: .finished)
}


example(of: "switchToLatest - Network Request") {
    let url = URL(string: "https://source.unsplash.com/random")!
    
    func getImage() -> AnyPublisher<UIImage?, Never> {
        URLSession.shared
            .dataTaskPublisher(for: url)
            .map {data, _ in UIImage(data: data) }
            .print("image")
            .replaceError(with: nil)
            .eraseToAnyPublisher()
    }
    
    let taps = PassthroughSubject<Void, Never>()
    
    taps
        .map { _ in getImage() }
        .switchToLatest()
        .sink(receiveValue: { _ in })
        .store(in: &subscriptions)
    
    taps.send()
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        taps.send()
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 3.1) {
        taps.send()
    }
}