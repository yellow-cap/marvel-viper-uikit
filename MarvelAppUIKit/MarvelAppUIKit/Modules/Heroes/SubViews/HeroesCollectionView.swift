import UIKit

struct HeroesCollectionViewProps: IViewProps {
    let heroes: [Hero]
    let loadHeroes: () -> Void
}

class HeroesCollectionView: UICollectionView,
        UICollectionViewDelegateFlowLayout,
        UICollectionViewDataSource,
        IView {
    private let cellReuseIdentifier = "heroes_collection_cell"
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
        backgroundColor = .blue
        register(HeroesCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
    }

    func update(_ newProps: IViewProps) {
        guard let props = newProps as? HeroesCollectionViewProps else {
            print("<<<DEV>> props is not HeroesCollectionViewProps")
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as? HeroesCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.update(HeroesCollectionViewCellProps(hero: props?.heroes[indexPath.item]))
        cell.backgroundColor = .red

        return cell
    }
}