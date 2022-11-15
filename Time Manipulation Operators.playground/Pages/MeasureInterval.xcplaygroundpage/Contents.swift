import Combine
import SwiftUI
import PlaygroundSupport

let subject = PassthroughSubject<String, Never>()

let measureSubject = subject.measureInterval(using: DispatchQueue.main)
let measureSubject2 = subject.measureInterval(using: RunLoop.main)

let subjectTimeline = TimelineView(title: "Emitted values")
let measureTimeline = TimelineView(title: "Measured values")

let view = VStack(spacing: 100) {
    subjectTimeline
    measureTimeline
}

PlaygroundPage.current.liveView = UIHostingController(rootView: view.frame(width: 375, height: 600))

subject.displayEvents(in: subjectTimeline)
measureSubject.displayEvents(in: measureTimeline)

let subscription1 = subject.sink { value in
    print("+\(deltaTime)s: Subject emitted: \(value)")
}

let subscription2 = measureSubject.sink { value in
    print("+\(deltaTime)s: Measure emitted: \(Double(value.magnitude) / 1_000_000_000.0)")
}

let subscription3 = measureSubject.sink { value in
    print("+\(deltaTime)s: Measure2 emitted: \(value)")
}

subject.feed(with: typingHelloWorld)
