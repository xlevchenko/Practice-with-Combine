import Combine
import SwiftUI
import PlaygroundSupport

let throttleDelay = 1.0

let subject = PassthroughSubject<String, Never>()

let throtted = subject
    .throttle(for: .seconds(throttleDelay), scheduler: DispatchQueue.main, latest: false)
    .share()

let subjectTimeline = TimelineView(title: "Emitted values")
let throttledTimeline = TimelineView(title: "Throttled values")

let view = VStack(spacing: 100) {
    subjectTimeline
    throttledTimeline
}

PlaygroundPage.current.liveView = UIHostingController(rootView: view.frame(width: 375, height: 600))

subject.displayEvents(in: subjectTimeline)
subject.displayEvents(in: throttledTimeline)


let subscription1 = subject
    .sink { string in
        print("+\(deltaTime)s: Subject emitted: \(string)")
    }
let subscription2 = throtted
    .sink { string in
        print("+\(deltaTime)s: Throtted emitted: \(string)")
    }

subject.feed(with: typingHelloWorld)
