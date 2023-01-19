import UIKit
import Combine

//let shared = URLSession.shared
//    .dataTaskPublisher(for: URL(string: "https://www.raywenderlich.com")!)
//    .map(\.data)
//    .print("shared")
//    .share()
//
//print("subscribing first")
//
//let subscription1 = shared.sink { _ in
//} receiveValue: {
//    print("subscription1 received: \($0)")
//}
//
//print("subscribing second")

//let subscription2 = shared.sink { _ in
//} receiveValue: {
//    print("subscription2 received: \($0)")
//}

//var subscription2: AnyCancellable? = nil
//
//DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//    print("subscribing second")
//    
//    subscription2 = shared.sink(
//        receiveCompletion: { print("subscription2 completion \($0)")},
//        receiveValue: { print("subcription2 received: \($0)") }
//    )
//}


let subject = PassthroughSubject<Data, URLError>()

let multicasted = URLSession.shared
    .dataTaskPublisher(for: URL(string: "https://www.raywenderlich.com")!)
    .map(\.data)
    .print("multicast")
    .multicast(subject: subject)

let subscription3 = multicasted
    .sink { _ in }
receiveValue: {
        print("subscription3 received: '\($0)'")
    }

let cancellable = multicasted.connect()
