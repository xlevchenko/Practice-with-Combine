import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()

example(of: "min") {
    let publisher = [1, -50, 246, 0].publisher
    
    publisher
        .print("publisher")
        .min()
        .sink(receiveValue: { print("Lowets value is: \($0)") })
        .store(in: &subscriptions)
}

example(of: "min non-Comparable") {
    let publisher = ["12345", "ab", "hello world"]
    
        .map { Data($0.utf8) }
        .publisher
    
    publisher
        .print("publisher")
        .min(by: { $0.count < $1.count})
        .sink { data in
            let string = String(data: data, encoding: .utf8)!
            print("Smallets data is: \(string), \(data.count) bytes")
        }
        .store(in: &subscriptions)
}


example(of: "max") {
    let publisher = ["A", "F", "Z", "E"].publisher
    
    publisher
        .print("publisher")
        .max()
        .sink(receiveValue: { print("Highest value is \($0)") })
        .store(in: &subscriptions)
}


example(of: "first") {
    let publisher  = ["A", "B", "C"].publisher
    
    publisher
        .print("publisher")
        .first()
        .sink(receiveValue: { print("First value is \($0)") })
        .store(in: &subscriptions)
}


example(of: "first(wher:)") {
    let publisher = ["J", "O", "H", "N"].publisher
    
    publisher
        .print("publisher")
        .first(where: { "Hello World" .contains($0) })
        .sink(receiveValue: { print("First match is \($0)") })
        .store(in: &subscriptions)
}

example(of: "last") {
    let publisher = ["A", "B", "C"].publisher
    
    publisher
        .print("publisher")
        .last()
        .sink(receiveValue: { print("Last value is \($0)") })
        .store(in: &subscriptions)
}

example(of: "output(at:)") {
    let publisher = ["A", "B", "C", "D"].publisher
    
    publisher
        .print("publisher")
        .output(at: 1)
        .sink(receiveValue: { print("Value at index 1 is \($0)") })
        .store(in: &subscriptions)
}

example(of: "output(in:)") {
    let publisher = ["A", "B", "C", "D", "E"].publisher
    
    publisher
        .output(in: 1...3)
        .sink(receiveValue: { print("Value at index 1 is \($0)") })
        .store(in: &subscriptions)
}


example(of: "count") {
    let publisher = ["A", "B", "C"].publisher
    
    publisher
        .print("publisher")
        .count()
        .sink(receiveValue: { print("I have \($0) items") })
        .store(in: &subscriptions)
}


example(of: "contains") {
    let publisher = ["A", "B", "C", "D", "E"].publisher
    let letter = "C"
    
    publisher
        .print("publisher")
        .contains(letter)
        .sink { contains in
            print(contains ? "Publisher emitted \(letter)!" : "Publisher never emitted \(letter)!")
        }
        .store(in: &subscriptions)
}


example(of: "contains(where:)") {
    struct Person {
        let id: Int
        let name: String
    }
    
    let people = [(123, "Shai Mishali"), (777, "Marin Todorov"), (214, "Florent Pillet")]
        .map(Person.init)
        .publisher
    
    people
        .contains(where: { $0.id == 800 || $0.name == "Marin Todorov"})
        .sink { contains in
            print(contains ? "Criteria matches!" : "Coundn't find a match for the criteria")
        }
        .store(in: &subscriptions)
}


example(of: "allSatisfy") {
    let publisher = stride(from: 0, through: 5, by: 2).publisher
    
    publisher
        .print("publisher")
        .allSatisfy { $0 % 2 == 0 }
        .sink { allEvent in
            print(allEvent ? "All numbers are even" : "Something is odd...")
        }
        .store(in: &subscriptions)
}


example(of: "reduce") {
    let publisher = ["Hel", "lo", " ", "Wor", "ld", "!"].publisher
    
    publisher
        .print("publisher")
        .reduce("") { accumulator, value in
            accumulator + value
        }
        .sink(receiveValue: { print("Reduced into: \($0)") })
        .store(in: &subscriptions)
}
