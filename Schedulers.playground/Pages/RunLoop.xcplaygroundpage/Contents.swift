import Combine
import SwiftUI
import PlaygroundSupport

var threadRecorder: ThreadRecorder? = nil

let source = Timer
  .publish(every: 1.0, on: .main, in: .common)
  .autoconnect()
  .scan(0) { (counter, _) in counter + 1 }

let setupPubliser = { recorder in
   source
        .subscribe(on: DispatchQueue.global())
    //.receive(on: DispatchQueue.global())
        .recordThread(using: recorder)
        .receive(on: RunLoop.current)
        .recordThread(using: recorder)
        .handleEvents(receiveSubscription: { _ in
            threadRecorder = recorder
        })
        .eraseToAnyPublisher()
}


RunLoop.current.schedule(
    after: .init(Date(timeIntervalSinceNow: 4.5)),
    tolerance: .milliseconds(500)) {
        threadRecorder?.subscription?.cancel()
}
let view = ThreadRecorderView(title: "Using RunLoop", setup: setupPubliser)
PlaygroundPage.current.liveView = UIHostingController(rootView: view)
