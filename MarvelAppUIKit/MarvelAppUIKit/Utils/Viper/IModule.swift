import UIKit

protocol IModule: class {
    func build(_ props: IProps?) -> UIViewController
}
