import Foundation
import Combine

private final class ShareReplaySubscription<Output, Failure: Error>: Subscription {
    
    let capacity: Int
    var subscriber: AnySubscriber<Output, Failure>? = nil
    var demand: Subscribers.Demand = .none
    var buffer: [Output]
    var completion: Subscribers.Completion<Failure>? = nil
    
    init<S>(subscriber: S,
            replay: [Output],
            capacity: Int,
            completion: Subscribers.Completion<Failure>?)
    where S: Subscriber, Failure == S.Failure, Output == S.Input  {
        
        self.subscriber = AnySubscriber(subscriber)
        self.buffer = replay
        self.capacity = capacity
        self.completion = completion
    }
    
    private func complete(with completion: Subscribers.Completion<Failure>) {
        
        guard let subscriber = subscriber else { return }
        
        self.subscriber = nil
        self.completion = nil
        self.buffer.removeAll()
        
        subscriber.receive(completion: completion)
    }
    
    private func emmitAsNeded() {
        guard let subscriber = subscriber else { return }
        
        while self.demand > .none && !buffer.isEmpty {
            self.demand = .max(1)
            
            let nextDemand = subscriber.receive(buffer.removeFirst())
            
            if nextDemand != .none {
                self.demand += nextDemand
            }
        }
        
        if let completion = completion {
            complete(with: completion)
        }
    }
    
    func request(_ demand: Subscribers.Demand) {
        if demand != .none {
            self.demand += demand
        }
        emmitAsNeded()
    }
    
    func cancel() {
        complete(with: .finished)
    }
    
    func receive(_ input: Output) {
        guard subscriber != nil else { return }
        
        buffer.append(input)
        
        if buffer.count > capacity {
            buffer.removeFirst()
        }
        emmitAsNeded()
    }
    
    func receive(completion: Subscribers.Completion<Failure>) {
        guard let subscriber = subscriber else { return }
        
        self.subscriber = nil
        self.buffer.removeAll()
        subscriber.receive(completion: completion)
    }
}
