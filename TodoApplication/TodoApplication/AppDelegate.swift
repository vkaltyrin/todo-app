import RealmSwift
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        if let navigationController = window?.rootViewController as? UINavigationController {
            let assembly = ListAssemblyImpl()
            let viewController = assembly.module()
            navigationController.setViewControllers([viewController], animated: false)
        }

        return true
    }
}
