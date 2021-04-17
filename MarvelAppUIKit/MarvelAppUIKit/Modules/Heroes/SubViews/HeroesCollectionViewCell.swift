import UIKit

struct HeroesCollectionViewCellProps: IViewProps {
    let hero: Hero?
}

class HeroesCollectionViewCell: UICollectionViewCell, IView {
    private var nameLabel = UILabel()
    private var descriptionLabel = UILabel()
    private var avatarView = AvatarView()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        initView()
        placeView()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = ""
        descriptionLabel.text = ""
        avatarView.prepareForReuse()
    }

    func update(_ newProps: IViewProps) {
        guard let props = newProps as? HeroesCollectionViewCellProps else {
            return
        }

        nameLabel.text = props.hero?.name ?? "-"
        descriptionLabel.text = props.hero?.description ?? "-"
        avatarView.update(AvatarViewProps(thumbnail: props.hero?.thumbnail))
    }

    private func initView() {
        nameLabel.font = UIFont.systemFont(ofSize: 18.0, weight: .light)
        nameLabel.textAlignment = .center

        descriptionLabel.font = UIFont.systemFont(ofSize: 14.0, weight: .light)
    }

    private func placeView() {
        contentView.addSubview(avatarView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            avatarView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            avatarView.heightAnchor.constraint(equalTo: contentView.widthAnchor, constant: -24),
            avatarView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            avatarView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),

            nameLabel.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 4),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),

            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
        ])
    }
}
