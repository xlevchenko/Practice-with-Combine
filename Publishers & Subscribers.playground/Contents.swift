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
    
    center.post(name: myNotification, object: nil)
    center.removeObserver(observer)
}
