import Foundation

protocol IHeroesFetcher {
    func fetchHeroes(
            _ completionHandler: @escaping ([Hero]?, ApiError?) -> Void,
            loadingOffset: Int,
            batchSize: Int
    )
}

class HeroesFetcher: IHeroesFetcher {
    private let apiFetcher: IApiFetcher
    private let decoder: JSONDecoder

    init(
            apiFetcher: IApiFetcher,
            decoder: JSONDecoder = .init()
    ) {
        self.apiFetcher = apiFetcher
        self.decoder = decoder
    }

    func fetchHeroes(
            _ completionHandler: @escaping ([Hero]?, ApiError?) -> Void,
            loadingOffset: Int,
            batchSize: Int
    ) {
        let path = ApiUrlBuilder.getHeroesUrl()
        let timeStamp = NSDate().timeIntervalSince1970

        apiFetcher.request(
                type: ApiRequestType.get,
                path: path,
                headers: [:],
                queryParams: [
                    "apikey": ApiConstants.marvelApiPublicKey,
                    "ts": "\(timeStamp)",
                    "hash": "\(timeStamp)\(ApiConstants.marvelApiPrivateKey)\(ApiConstants.marvelApiPublicKey)"
                            .md5(),
                    "offset": "\(loadingOffset)",
                    "limit": "\(batchSize)"
                ],
                completionHandler: { [weak self] result in
                    self?.onFetchHeroesComplete(result, completionHandler)
                }
        )
    }

    private func onFetchHeroesComplete(
            _ result: Result<Data?, ApiError>,
            _ completionHandler: @escaping ([Hero]?, ApiError?) -> Void
    ) {
        switch result {
        case let .success(data):
            do {
                let parsedHeroes = try decoder.decode(HeroesApiResponse.self, from: data!)

                DispatchQueue.main.async {
                    completionHandler(parsedHeroes.data.results, nil)
                }

            } catch {
                DispatchQueue.main.async {
                    completionHandler(
                            nil,
                            ApiError(message: "HeroesFetcher: Couldn't parse response data", error: nil)
                    )
                }
            }
        case let .failure(error):
            DispatchQueue.main.async {
                completionHandler(nil, error)
            }
        }
    }
}