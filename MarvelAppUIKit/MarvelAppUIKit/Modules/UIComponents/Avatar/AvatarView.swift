import UIKit
import Foundation

struct AvatarViewProps: IViewProps {
    let thumbnail: HeroThumbnail?
}

class AvatarView: UIView, IView {
    private var imageView = UIImageView()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        placeView()
    }

    func update(_ newProps: IViewProps) {
        guard let props = newProps as? AvatarViewProps else {
            return
        }

        loadImage(props.thumbnail)
    }

    private func loadImage(_ thumbnail: HeroThumbnail?) {
        guard let thumbnail = thumbnail else {
            return
        }

        guard let url = URL(string: "\(thumbnail.path).\(thumbnail.extension)") else {
            return
        }

        print("<<<DEV>>> Avatar url: \(url)")
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.imageView.image = image
                    }
                }
            }
        }
    }

    private func placeView() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
