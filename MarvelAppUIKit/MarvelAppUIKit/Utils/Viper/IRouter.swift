import UIKit

protocol IRoute {}

protocol IRouter {
    var parentController: UIViewController? { get set }
    func routeTo(to: IRoute, props: IProps?)
}
