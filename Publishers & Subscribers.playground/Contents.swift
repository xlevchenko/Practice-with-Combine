import UIKit
import Combine

var subscriptions = Set<AnyCancellable>()

example(of: "Publisher") {
    let myNotification = Notification.Name("MyNotification")
    
    let publisher = NotificationCenter.default
        .publisher(for: myNotification)
    
    let center = NotificationCenter.default
    let observer = center.addObserver(forName: myNotification, object: nil, queue: nil) { notification in
        print("Notification received!")
    }
    
    let subscription = publisher
        .sink { _ in
            print("Notification recived from a publisher!")
        }
    
    center.post(name: myNotification, object: nil)
    
    subscription.cancel()
    center.removeObserver(observer)
}


example(of: "Subscriber") {
    let myNotification = Notification.Name("MyNotification")
    let center = NotificationCenter.default
    
    let publisher = center.publisher(for: myNotification)
}


example(of: "Just") {
    let just = Just("Hello World!")
    
    _ = just
        .sink(receiveCompletion: {
            print("Received completion", $0)
        }, receiveValue: {
            print("Received value", $0)
        })
   
    _ = just
        .sink(receiveCompletion: {
            print("Received completion (another)", $0)
        }, receiveValue: {
            print("Received value (another)", $0)
        })
}


example(of: "assing(to:on:)") {
    
    class SomeObject {
        var value: String = "" {
            didSet {
                print(value)
            }
        }
    }
    
    let object = SomeObject()
    let publisher = ["Hello", "World!"].publisher
    
    _ = publisher
        .assign(to: \.value, on: object)
}
