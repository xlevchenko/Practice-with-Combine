import Combine
import SwiftUI
import PlaygroundSupport

let valuePerSecond = 1.0
let collectTimeStride = 4

let sourcePublisher = PassthroughSubject<Date, Never>()

let collectedPublisher = sourcePublisher
    .collect(.byTime(DispatchQueue.main, .seconds(collectTimeStride)))
    .flatMap { dates in dates.publisher }

let subscription = Timer
    .publish(every: 1.0 / valuePerSecond, on: .main, in: .common)
    .autoconnect()
    .subscribe(sourcePublisher)

let sourceTimeline = TimelineView(title: "Emitted values:")
let collectedTimeline = TimelineView(title: "Collected values (every \(collectTimeStride)s):")

let view = VStack(spacing: 40) {
    sourceTimeline
    collectedTimeline
}

PlaygroundPage.current.liveView = UIHostingController(rootView: view.frame(width: 375, height: 600))

sourcePublisher.displayEvents(in: sourceTimeline)
collectedPublisher.displayEvents(in: collectedTimeline)
