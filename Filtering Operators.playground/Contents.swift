import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()

example(of: "filter") {
    let numbers = (1...10).publisher
    
    numbers
        .filter { $0.isMultiple(of: 3) }
        .sink { number in
            print("\(number) is multiple of 3!")
        }
        .store(in: &subscriptions)
}
