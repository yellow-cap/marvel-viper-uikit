import UIKit

struct HeroDetailsTableViewProps: IProps {
    let details: [String]
}

class HeroDetailsTableView: UITableView,
        UITableViewDelegate,
        UITableViewDataSource,
        IView {
    private let cellReuseIdentifier = "hero_details_table_cell"
    private var props: HeroDetailsTableViewProps? = nil

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect, style: Style) {
        super.init(frame: frame, style: style)
        initTable()
    }

    func update(_ newProps: IProps) {
        guard let props = newProps as? HeroDetailsTableViewProps else {
            return
        }

        self.props = props

        reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        props?.details.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell()
        cell.textLabel?.text = props?.details[indexPath.item]

        return cell
    }

    private func initTable() {
        register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        delegate = self
        dataSource = self
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = 60
        allowsSelection = false
    }
}
