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


//let subject = PassthroughSubject<Data, URLError>()
//
//let multicasted = URLSession.shared
//    .dataTaskPublisher(for: URL(string: "https://www.raywenderlich.com")!)
//    .map(\.data)
//    .print("multicast")
//    .multicast(subject: subject)
//
//let subscription3 = multicasted
//    .sink { _ in }
//receiveValue: {
//        print("subscription3 received: '\($0)'")
//    }
//
//let cancellable = multicasted.connect()

//Future

func performeSomeWork() throws -> Int {
    print("Preforming some work and returning a result")
    return 5
}

let future = Future <Int, Error> { fulfill in
    do {
        let result = try performeSomeWork()
        fulfill(.success(result))
    } catch {
        fulfill(.failure(error))
    }
}

print("Subscribing to future...")


let subcription1 = future
    .sink { _ in
        print("subcription 1 completed")
    } receiveValue: {
        print("subcription1 recived: '\($0)'")
    }

let subscription2 = future
    .sink { _ in
        print("subcription2 completed")
    } receiveValue: {
        print("subcription2 recived: \($0)")
    }

