import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()
//: ## Never
example(of: "Never sink") {
    Just("Hello")
        .sink(receiveValue:  { print ($0) })
        .store(in: &subscriptions)
}


enum MyError: Error {
    case ohNo
}

example(of: "setFailureType") {
    Just("Hello")
        .setFailureType(to: MyError.self)
        .sink { completion in
            switch completion {
            case .failure(.ohNo):
                print("Finished with Oh No!")
            case .finished:
                print("Finished successflly!")
            }
        } receiveValue: { value in
            print("Go to value: \(value)")
        }
        .store(in: &subscriptions)
    //.eraseToAnyPublisher()
}


example(of: "assign(to:on:)") {
    
    class Person {
        let id = UUID()
        let name = "Unknown"
    }
    
    let person = Person()
    print("1", person.name)
    
    Just("Shai")
        .handleEvents(receiveCompletion: { _ in
            print("2", person.name)
        })
        .assign(to: \.name, on: person)
        .store(in: &subscriptions)
}
//: [Next](@next)

