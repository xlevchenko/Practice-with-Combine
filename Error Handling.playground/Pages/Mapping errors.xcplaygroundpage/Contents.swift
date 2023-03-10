//: [Previous](@previous)
import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()
//:## Mapping errors
example(of: "map vs tryMap") {
    
    enum NameError: Error {
        case tooShort(String)
        case unowned
    }
    
    Just("Hello")
        .setFailureType(to: NameError.self)
        .tryMap { value in
            throw NameError.tooShort(value)
        }
        .mapError({ error in
            error as? NameError ?? .unowned
        })
    
        .sink { completion in
            switch completion {
            case .finished:
                print("Done!")
            case .failure(.tooShort(let name)):
                print("\(name) is to short")
            case .failure(.unowned):
                print("An unknown name errro occurred")
            }
        } receiveValue: { value in
            print("Got value \(value)")
        }
        .store(in: &subscriptions)
}
