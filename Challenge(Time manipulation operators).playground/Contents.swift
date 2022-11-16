import Combine
import Foundation

// A subject you get values from
let subject = PassthroughSubject<Int, Never>()

let strings = subject
    .collect(.byTime(DispatchQueue.main, .seconds(0.5)))
    .map { array in
        String(array.map { Character(UnicodeScalar($0)!) })
    }

let spaces = subject.measureInterval(using: DispatchQueue.main)
    .map { interval in
        interval > 0.9 ? "☺️" : ""
    }

let subscription = strings
    .merge(with: spaces)
    .filter({ !$0.isEmpty })
    .sink {
        print($0)
    }
