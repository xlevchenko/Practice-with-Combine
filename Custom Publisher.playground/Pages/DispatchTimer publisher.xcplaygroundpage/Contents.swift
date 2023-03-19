import Foundation
import Combine

struct DispatchTimerConfiguration {
    
    let queue: DispatchQueue?
    
    let interval: DispatchTimeInterval
    
    let leeway: DispatchTimeInterval
    
    let times: Subscribers.Demand
}


extension Publishers {
    
    struct DispatchTimer: Publisher {
        
        typealias Output = DispatchTime
        typealias Failure = Never
        
        let configuration: DispatchTimerConfiguration
        
        init(configuration: DispatchTimerConfiguration) {
            self.configuration = configuration
        }
        
        func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, DispatchTime == S.Input {
            let subscription = DispatchTimerSubscription(subscriber: subscriber, configuration: configuration)
            
            subscriber.receive(subscription: subscription)
        }
    }
    
    private final class DispatchTimerSubscription<S: Subscriber>: Subscription where S.Input == DispatchTimer {
        
        let configuration: DispatchTimerConfiguration
        
        let times: Subscribers.Demand
        
        var requested: Subscribers.Demand = .none
        
        var source: DispatchSourceTimer? = nil
        
        var subscriber: S?
        
        init(subscriber: S, configuration: DispatchTimerConfiguration) {
            self.configuration = configuration
            self.subscriber = subscriber
            self.times = configuration.times
        }
        
        func request(_ demand: Subscribers.Demand) {
            <#code#>
        }
        
        func cancel() {
            source = nil
            subscriber = nil
        }
    }
}
