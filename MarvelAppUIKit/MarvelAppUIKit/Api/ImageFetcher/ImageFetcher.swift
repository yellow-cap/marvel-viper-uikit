import Foundation
import UIKit

protocol IImageFetcher {
    func loadImage(url: URL, _ completionHandler: @escaping (Result<UIImage, Error>) -> Void) -> UUID?
    func cancelLoadingTask(_ uuid: UUID)
}

class ImageFetcher: IImageFetcher {
    internal var loadedImages: [URL: UIImage] = [:]
    internal var runningTasks: [UUID: URLSessionDataTask] = [:]

    func loadImage(url: URL, _ completionHandler: @escaping (Result<UIImage, Error>) -> Void) -> UUID? {
        if let image = loadedImages[url] {
            completionHandler(.success(image))
            return nil
        }

        let uuid = UUID()

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            defer { self.runningTasks.removeValue(forKey: uuid) }

            if let data = data, let image = UIImage(data: data) {
                self.loadedImages[url] = image

                completionHandler(.success(image))

                return
            }

            guard let err = error as NSError?, err.code == NSURLErrorCancelled else {
                completionHandler(.failure(
                        ApiError(message: "ImageFetcher: fail to load image", error: error)
                ))

                return
            }
        }

        task.resume()

        runningTasks[uuid] = task

        return uuid
    }

    func cancelLoadingTask(_ uuid: UUID) {
        runningTasks[uuid]?.cancel()
        runningTasks.removeValue(forKey: uuid)
    }
}
