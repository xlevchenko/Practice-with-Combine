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

example(of: "removeDuplicates") {
    let words = "hey hey there! want to listen to mister mister ?"
        .components(separatedBy: " ")
        .publisher
    
    words
        .removeDuplicates()
        .sink(receiveValue: { print($0) })
        .store(in: &subscriptions)
}


example(of: "compactMap") {
    let string = ["a", "1.24", "3", "def", "45", "0.23"].publisher
    
    string
        .compactMap({ Float($0) })
        .sink(receiveValue: { print($0) })
        .store(in: &subscriptions)
}


example(of: "ignonoreOutput") {
    let numbers = (1...10_000).publisher
    
    numbers
        .ignoreOutput()
        .sink(receiveCompletion: { print("Completed with: \($0)") },
              receiveValue: { print($0) })
        .store(in: &subscriptions)
}
