import UIKit

protocol IHeroDetailsView: IView {
    var presenter: IHeroDetailsPresenter? { get set }
}

struct HeroDetailsViewProps: IProps {
    let hero: Hero
}

class HeroDetailsView: UIViewController, IHeroDetailsView {
    var presenter: IHeroDetailsPresenter?

    private let segmentedControl = UISegmentedControl()
    private var selectedSegmentIndex: Int = 0
    private let tableView = HeroDetailsTableView()
    private var props: HeroDetailsViewProps? = nil

    override func loadView() {
        super.loadView()
        initView()
        placeView()
    }

    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        presenter?.getHero()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }

    func update(_ newProps: IProps) {
        guard let props = newProps as? HeroDetailsViewProps else {
            return
        }

        self.props = props

        title = props.hero.name
        tableView.update(HeroDetailsTableViewProps(
                details: props.hero.comics.items.map { $0.name }
        ))
    }

    private func initView() {
        setupSegmentedControl()
    }

    private func placeView() {
        view.addSubview(segmentedControl)
        view.addSubview(tableView)

        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 102),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),

            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupSegmentedControl() {
        segmentedControl.insertSegment(withTitle: "Comics", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Stories", at: 1, animated: false)
        segmentedControl.insertSegment(withTitle: "Events", at: 2, animated: false)
        segmentedControl.insertSegment(withTitle: "Series", at: 3, animated: false)

        segmentedControl.selectedSegmentIndex = selectedSegmentIndex
        segmentedControl.addTarget(self, action: #selector(onSegmentChange), for: .valueChanged)
    }
    
    @objc private func onSegmentChange(sender: UISegmentedControl) {
        guard let props = props else {
            return
        }

        selectedSegmentIndex = sender.selectedSegmentIndex

        switch selectedSegmentIndex {
        case SegmentedControlSections.comics.rawValue:
            tableView.update(HeroDetailsTableViewProps(
                    details: props.hero.comics.items.map { $0.name }
            ))

        case SegmentedControlSections.stories.rawValue:
            tableView.update(HeroDetailsTableViewProps(
                    details: props.hero.stories.items.map { $0.name }
            ))

        case SegmentedControlSections.events.rawValue:
            tableView.update(HeroDetailsTableViewProps(
                    details: props.hero.events.items.map { $0.name }
            ))

        case SegmentedControlSections.series.rawValue:
            tableView.update(HeroDetailsTableViewProps(
                    details: props.hero.series.items.map { $0.name }
            ))
            
        default:
            print("No such segment with id \(selectedSegmentIndex) in segmented control")
        }
    }
}

extension HeroDetailsView {
    private enum SegmentedControlSections: Int {
        case comics = 0
        case stories = 1
        case events = 2
        case series = 3
    }
}
