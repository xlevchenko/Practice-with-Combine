import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()

example(of: "collect") {
    ["A", "B", "C", "D", "E"].publisher
        .collect(2)
        .sink(receiveCompletion: { print($0) },
              receiveValue: { print($0) })
        .store(in: &subscriptions)
}

example(of: "map") {
    let formatter = NumberFormatter()
    formatter.numberStyle = .spellOut
    
    [123, 4, 56].publisher
        .map {
            formatter.string(from: NSNumber(integerLiteral: $0)) ?? ""
        }
        .sink(receiveValue: { print($0) })
        .store(in: &subscriptions)
}


example(of: "mapping key paths") {
    let publisher = PassthroughSubject<Coordinate, Never>()
    
    publisher
        .map(\.x, \.y)
        .sink { x, y in
            print("The cordinate at (\(x), \(y)) is in quadrant", quadrantOf(x: x, y: y))
        }
        .store(in: &subscriptions)
    
    publisher.send(Coordinate(x: 10, y: -8))
    publisher.send(Coordinate(x: 0, y: 5))
}


example(of: "tryMap") {
    Just("Directory name that does not exist")
    
        .tryMap{ try FileManager.default.contentsOfDirectory(atPath: $0) }
        .sink(receiveCompletion: { print($0) }, receiveValue: {print($0) })
        .store(in: &subscriptions)
}


example(of: "flatMap") {
    func decode(_ codes: [Int]) -> AnyPublisher<String, Never> {
        Just(
            codes
                .compactMap({ code in
                    guard (32...255).contains(codes) else { return nil }
                    return String(UnicodeScalar(code) ?? " ")
                })
                .joined()
        )
        .eraseToAnyPublisher()
    }
    
    [72, 101, 108, 108, 111, 44, 32, 87, 111, 114, 108, 100, 33].publisher
        .collect()
        .flatMap(decode)
        .sink(receiveValue: { print($0) })
        .store(in: &subscriptions)
}
