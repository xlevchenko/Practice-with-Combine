import Combine
import SwiftUI
import PlaygroundSupport

let subject = PassthroughSubject<String, Never>()
let debounced = subject
    .debounce(for: .seconds(1.0), scheduler: DispatchQueue.main)
    .share()


let subjectTimeline = TimelineView(title: "Emitted values")
let debouncedTimeline = TimelineView(title: "Debounced values")

let view = VStack(spacing: 100) {
    subjectTimeline
    debouncedTimeline
}

let subscription1 = subject
    .sink { string in
        print("+\(deltaTime)s: Subject emitted: \(string)")
    }

let subscription2 = debounced
    .sink { string in
        print("+\(deltaTime)s: Subject emitted: \(string)")
    }



PlaygroundPage.current.liveView = UIHostingController(rootView: view.frame(width: 375, height: 600))

//subject.displayEvents(in: subjectTimeline)
//debounced.displayEvents(in: debouncedTimeline)
//subject.feed(with: typingHelloWorld)
