
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		let w = UIWindow()
		w.backgroundColor = UIColor.white
		let router = Router("main")
		router["main"] = {Main()}
		router["sub1"] = {Sub1()}
		router["sub2"] = {Sub2()}
		window = w
		let base = UINavigationController() //UIViewController()
		w.rootViewController = base
		router.route(base, Router.type.replace).with("main")
		w.makeKeyAndVisible()

        test_Module()

		return true
	}
}

func test_Module() {
    let v: TestView! = UINib.instantiate()
    print(v)
//    let vc: TestVC? = UINib.instantiate()
//    print(vc ?? "(생성 실패)")
}
