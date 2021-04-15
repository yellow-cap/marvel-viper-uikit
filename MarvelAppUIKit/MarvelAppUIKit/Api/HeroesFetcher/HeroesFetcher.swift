import Foundation

protocol IHeroesFetcher {
    func fetchHeroes(completionHandler: @escaping (Result<Data?, ApiError>) -> Void)
}

class HeroesFetcher: IHeroesFetcher {
    private let apiFetcher: IApiFetcher

    init(
            apiFetcher: IApiFetcher
    ) {
        self.apiFetcher = apiFetcher
    }

    func fetchHeroes(completionHandler: @escaping (Result<Data?, ApiError>) -> Void) {
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
                completionHandler: completionHandler
        )
    }
}