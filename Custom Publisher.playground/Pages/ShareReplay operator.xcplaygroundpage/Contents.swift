import Foundation
import Combine

private final class ShareReplaySubscription<Output, Failure: Error>: Subscription {
    
    let copacity: Int
    var subscriber: AnySubscriber<Output, Failure>? = nil
    var demand: Subscribers.Demand = .none
    var buffer: [Output]
    var complition: Subscribers.Completion<Failure>? = nil
}
