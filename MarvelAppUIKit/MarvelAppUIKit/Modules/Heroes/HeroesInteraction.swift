import Foundation
import UIKit

protocol IHeroesInteraction: IInteraction {
    var presenter: IHeroesPresenter? { get set }
    func getHeroes()
    func loadImage(url: URL, _ completionHandler: @escaping (Result<UIImage, Error>) -> Void) -> UUID?
    func cancelLoadingTask(_ uuid: UUID)
}

class HeroesInteraction: IHeroesInteraction, HeroesServiceDelegate {
    weak var presenter: IHeroesPresenter?
    private var heroesService: IHeroesService
    private var imageFetcher: IImageFetcher

    private var heroes = [Hero]()

    init(heroesService: IHeroesService, imageFetcher: IImageFetcher) {
        self.heroesService = heroesService
        self.imageFetcher = imageFetcher

        self.heroesService.delegate = self
    }

    func getHeroes() {
        let loadingOffset = heroes.count

        heroesService.getHeroes(loadingOffset: loadingOffset)
    }

    func onGetHeroesComplete(heroes: [Hero]?, error: Error?) {
        if let error = error {
            // presenter show error

            return
        }

        guard let heroes = heroes else {
            // presenter show error
            return
        }

        self.heroes.append(contentsOf: heroes)
        presenter?.updateView(heroes: self.heroes)
    }

    func loadImage(url: URL, _ completionHandler: @escaping (Result<UIImage, Error>) -> Void) -> UUID? {
        imageFetcher.loadImage(url: url, completionHandler)
    }

    func cancelLoadingTask(_ uuid: UUID) {
        imageFetcher.cancelLoadingTask(uuid)
    }
}