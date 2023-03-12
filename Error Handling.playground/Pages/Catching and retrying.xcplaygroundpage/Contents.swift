//: [Previous](@previous)
import UIKit
import Combine

var subscriptions = Set<AnyCancellable>()
//: ## Catching and retrying
let photoService = PhotoService()

example(of: "Catching and retrying") {
    photoService
        .fetchPhoto(quality: .high)
        .handleEvents(receiveSubscription: { _ in
            print("Trying...")
        }, receiveCompletion: { value in
            guard case .failure(let error) = value else {
                return
            }
            print("Got error: \(error)")
        })
    
        .retry(3)
        .catch({ error -> PhotoService.Publisher in
            print("Failed fetching high quality, falling back to low quality.")
            return photoService.fetchPhoto(quality: .low)
        })
        .replaceError(with: UIImage(named: "na.jpg")!)
        .sink { photo in
            print("\(photo)")
        } receiveValue: { image in
            image
            print("Got image: \(image)")
        }
        .store(in: &subscriptions)
}

