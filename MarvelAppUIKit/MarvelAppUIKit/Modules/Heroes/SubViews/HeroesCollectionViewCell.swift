import UIKit

class HeroesCollectionViewCell: UICollectionViewCell {
    private var nameLabel = UILabel()
    private var descriptionLabel = UILabel()
    private var imageView = UIImageView()

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
        descriptionLabel.text = ""

        super.prepareForReuse()
    }

    func update(name: String, description: String) {
        nameLabel.text = name
        descriptionLabel.text = description
        imageView.image = nil
    }

    private func initView() {
        nameLabel.font = UIFont.systemFont(ofSize: 18.0, weight: .light)
        nameLabel.textAlignment = .center

        descriptionLabel.font = UIFont.systemFont(ofSize: 14.0, weight: .light)

        imageView.backgroundColor = .yellow
    }

    private func placeView() {
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            imageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, constant: -24),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),

            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),

            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
        ])
    }
}
