import Foundation
import Combine

let computationPablisher = Publishers.ExpensiveComputation(duration: 3)

let queue = DispatchQueue(label: "serial queue")

let currentThread = Thread.current.number

print("Start compulation publisher on theread \(currentThread)")

let subcribtion = computationPablisher
    .subscribe(on: queue)
    .receive(on: DispatchQueue.main)
    .sink { value in
        let thread = Thread.current.number
        print("Received computation result on thread \(thread): '\(value)'")
    }
