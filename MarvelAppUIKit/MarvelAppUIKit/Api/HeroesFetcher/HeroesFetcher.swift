import Foundation

protocol IHeroesFetcher {
    func fetchHeroes(completionHandler: @escaping ([Hero]?, ApiError?) -> Void)
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

    func fetchHeroes(completionHandler: @escaping ([Hero]?, ApiError?) -> Void) {
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
                            .md5()
                ],
                completionHandler: { [weak self] result in
                    self?.onFetchHeroesComplete(result, completionHandler)
                }
        )
    }

    private func onFetchHeroesComplete(
            _ result: Result<Data?, ApiError>,
            _ completionHandler: ([Hero]?, ApiError?) -> Void
    ) {
        switch result {
        case let .success(data):
            do {
                let parsedHeroes = try decoder.decode(HeroesApiResponse.self, from: data!)
                completionHandler(parsedHeroes.data.results, nil)

            } catch {
                completionHandler(
                        nil,
                        ApiError(message: "WeatherForecastFetcher: Couldn't parse response data")
                )
            }
        case let .failure(error):
            completionHandler(
                    nil,
                    ApiError(message: error.localizedDescription)
            )
        }
    }
}