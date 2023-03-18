import Combine
import Foundation

extension Publisher {
    func unwrap<T>() -> Publishers.CompactMap<Self, T> where  Output == Optional<T> {
        compactMap { value in
            value
        }
    }
}


let values: [Int?] = [1, 2, nil, 3, nil, 4]

values.publisher
    .unwrap()
    .sink { value in
        print("Received value: \(value)")
    }
