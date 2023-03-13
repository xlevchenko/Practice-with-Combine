import Combine
import SwiftUI
import PlaygroundSupport

let source = Timer
    .publish(every: 1.0, on: .main, in: .common)
    .autoconnect()
    .scan(0) { counter, _ in
        counter + 1
    }

let setupPublisher = { recoder in
   source
        .recordThread(using: recoder)
        .receive(on: ImmediateScheduler.shared)
        .receive(on: DispatchQueue.global())
        .recordThread(using: recoder)
        .eraseToAnyPublisher()
}

let view = ThreadRecorderView(title: "Using ImmediateScheduler", setup: setupPublisher)

PlaygroundPage.current.liveView = UIHostingController(rootView: view)
