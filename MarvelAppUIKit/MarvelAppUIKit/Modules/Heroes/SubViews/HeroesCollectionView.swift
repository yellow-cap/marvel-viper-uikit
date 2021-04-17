import UIKit

struct HeroesCollectionViewProps: IProps {
    let heroes: [Hero]
    let loadHeroes: () -> Void
    let loadAvatar: (URL, @escaping (Result<UIImage, Error>) -> Void) -> UUID?
    let cancelAvatarLoading: (UUID) -> Void
}

class HeroesCollectionView: UICollectionView,
        UICollectionViewDelegateFlowLayout,
        UICollectionViewDataSource,
        IView {
    private let cellReuseIdentifier = "heroes_collection_cell"
    private let cellsBeforeLoading = 4
    private var props: HeroesCollectionViewProps? = nil

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)

        super.init(frame: frame, collectionViewLayout: layout)

        delegate = self
        dataSource = self
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        register(HeroesCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
    }

    func update(_ newProps: IProps) {
        guard let props = newProps as? HeroesCollectionViewProps else {
            return
        }

        self.props = props

        reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width / 2.5, height: collectionView.frame.width / 2)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        props?.heroes.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let props = props else { return UICollectionViewCell() }

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as? HeroesCollectionViewCell else {
            return UICollectionViewCell()
        }

        guard props.heroes.count > 0 else {
            return UICollectionViewCell()
        }

        if indexPath.item == props.heroes.count - cellsBeforeLoading {
            props.loadHeroes()
        }

        cell.update(HeroesCollectionViewCellProps(
                hero: props.heroes[indexPath.item],
                loadAvatar: props.loadAvatar,
                cancelAvatarLoading: props.cancelAvatarLoading)
        )

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: Foundation.IndexPath) {
        print("Tap on item \(indexPath.item)")
    }
}