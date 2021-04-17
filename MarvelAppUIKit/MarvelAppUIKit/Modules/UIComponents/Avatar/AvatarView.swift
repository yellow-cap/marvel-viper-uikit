import UIKit
import Foundation

struct AvatarViewProps: IViewProps {
    let thumbnail: HeroThumbnail?
    let loadAvatar: (URL, @escaping (Result<UIImage, Error>) -> Void) -> UUID?
    let cancelAvatarLoading: (UUID) -> Void
}

class AvatarView: UIView, IView {
    private var imageView = UIImageView()
    private var props: AvatarViewProps? = nil
    var loadingTaskId: UUID? = nil

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

        self.props = props

        loadImage(props)
    }

    private func loadImage(_ props: AvatarViewProps) {
        guard let thumbnail = props.thumbnail else {
            return
        }

        guard let url = URL(string: "\(thumbnail.path).\(thumbnail.extension)") else {
            return
        }

        loadingTaskId = props.loadAvatar(url) { result in
            do {
                let image = try result.get()
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            } catch {
                print("Image loading error \(error)")
            }
        }
    }

    func prepareForReuse() {
        imageView.image = nil

        if loadingTaskId != nil {
            props?.cancelAvatarLoading(loadingTaskId!)
            loadingTaskId = nil
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
