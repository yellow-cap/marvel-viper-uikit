import UIKit

class HeroesCollectionViewCell: UICollectionViewCell {
    private var nameLabel: UILabel = UILabel()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        initView()
        placeView()
    }

    override func prepareForReuse() {
        nameLabel.text = ""

        super.prepareForReuse()
    }

    func update(name: String) {
        nameLabel.text = name
    }

    private func initView() {
        nameLabel.font = UIFont.systemFont(ofSize: 20.0, weight: .light)
    }

    private func placeView() {
        contentView.addSubview(nameLabel)

        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
        ])
    }
}
