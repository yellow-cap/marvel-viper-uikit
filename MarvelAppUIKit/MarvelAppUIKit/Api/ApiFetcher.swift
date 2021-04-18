import Foundation

protocol IApiFetcher {
    func request(
            type: ApiRequestType,
            path: String,
            headers: [String: String],
            queryParams: [String: String],
            completionHandler: @escaping (Result<Data?, ApiError>) -> Void
    )
}

class ApiFetcher: IApiFetcher {
    private let session = URLSession.shared

    func request(
            type: ApiRequestType,
            path: String,
            headers: [String: String],
            queryParams: [String: String],
            completionHandler: @escaping (Result<Data?, ApiError>) -> Void
    ) {
        guard let url = buildRequestUrl(path: path, queryParams: queryParams) else {
            completionHandler(
                    .failure(
                            ApiError(
                                    message: "ApiFetcher: Couldn't build request url.",
                                    error: nil
                            )
                    )
            )

            return
        }

        var request = URLRequest(url: url)

        headers.forEach {
            request.setValue($0.value, forHTTPHeaderField: $0.key)
        }

        request.httpMethod = type.rawValue

        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completionHandler(
                        .failure(
                                ApiError(
                                        message: "ApiFetcher: Api response error.",
                                        error: error
                                )
                        )
                )

                return
            }

            guard let response = response as? HTTPURLResponse else {
                completionHandler(
                        .failure(
                                ApiError(
                                        message: "ApiFetcher: Couldn't get response as HTTPURLResponse.",
                                        error: nil
                                )
                        )
                )

                return
            }

            guard response.statusCode == 200 else {
                completionHandler(
                        .failure(
                                ApiError(
                                        message: "ApiFetcher: Api response code: \(response.statusCode).",
                                        error: nil
                                )
                        )
                )

                return
            }

            guard let data = data else {
                completionHandler(
                        .failure(
                                ApiError(
                                        message: "ApiFetcher: Couldn't get data from response",
                                        error: nil)
                        )
                )

                return
            }

            completionHandler(.success(data))
        }

        task.resume()
    }

    private func buildRequestUrl(path: String, queryParams: [String: String]) -> URL? {
        guard let encodedPath = path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return nil
        }

        guard var urlComponents = URLComponents(string: encodedPath) else {
            return nil
        }

        urlComponents.percentEncodedQuery = urlComponents.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        urlComponents.queryItems = queryParams.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }

        return urlComponents.url
    }
}
