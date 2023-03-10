//: [Previous](@previous)
import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()
//: ## try* operators
example(of: "tryMap") {
    enum NameError: Error {
        case tooShort(String)
        case unowned
    }
    
    let names = ["Marin", "Shai", "Florent"].publisher
    
    names
        .tryMap { value -> Int in
            
            let lenght = value.count
            
            guard lenght >= 5 else {
                throw  NameError.tooShort(value)
            }
            
            return value.count
        }
    
        .sink { value in
            print("Completed with \(value)")
        } receiveValue: { count in
            print("Got value \(count)")
        }

}

