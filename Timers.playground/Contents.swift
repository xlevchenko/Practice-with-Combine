import UIKit
import Combine

let runLoop = RunLoop.main

//let subscription = runLoop.schedule(
//    after: runLoop.now,
//    interval: .seconds(1),
//    tolerance: .microseconds(100)
//) {
//    print("Timer fierd")
//}
//
//runLoop.schedule(after: .init(Date(timeIntervalSinceNow: 3.0))) {
//    subscription.cancel()
//}


//let publisher = Timer
//    .publish(every: 1.0, on: .main, in: .common)
//    .autoconnect()
//
//let subcription = Timer
//    .publish(every: 1.0, on: .main, in: .common)
//    .autoconnect()
//    .scan(0) { counter, _ in  counter + 1 }
//    .sink { counter in
//        print("Counter is \(counter)")
//    }

let queue = DispatchQueue.main

let source = PassthroughSubject<Int, Never>()

var counter = 0

let cancellabe = queue.schedule(
    after: queue.now,
    interval: .seconds(1)
) {
    source.send(counter)
    counter += 1
}

let subcription = source.sink {
    print("Timer emitted \($0)")
}
