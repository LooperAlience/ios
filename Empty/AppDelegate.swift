
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        var ret: Any?
        var t: Any?
        ret = ChType.parse("@b://true", nil)
        t = ChType.is(true)
        if let ret = ret as? Bool, let t = t as? ChType {
            print("B true:\(ret == true) \(t == ChType.b())")
        }

        ret = ChType.parse("@i8://5", nil)
        let v0: Int8 = 5
        t = ChType.is(v0)
        if let ret = ret as? Int8, let t = t as? ChType {
            print("I8 \(v0):\(ret == v0) \(t == ChType.i8())")
        }

        ret = ChType.parse("@i16://257", nil)
        let v1: Int16 = 257
        t = ChType.is(v1)
        if let ret = ret as? Int16, let t = t as? ChType {
            print("I16 \(v1):\(ret == v1) \(t == ChType.i16())")
        }

        ret = ChType.parse("@i32://257", nil)
        let v2: Int32 = 257
        t = ChType.is(v2)
        if let ret = ret as? Int32, let t = t as? ChType {
            print("I32 \(v2):\(ret == v2) \(t == ChType.i32())")
        }

        ret = ChType.parse("@i64://257", nil)
        let v3: Int64 = 257
        t = ChType.is(v3)
        if let ret = ret as? Int64, let t = t as? ChType {
            print("I64 \(v3):\(ret == v3) \(t == ChType.i64())")
        }

//        let v4: Float80 = 257.35
//        ret = ChType.parse("@f80://\(v4)", nil)
//        t = ChType.is(v4)
//        if let ret = ret as? Float80, let t = t as? ChType {
//            print("I16 \(v4):\(ret == v4) \(t == ChType.f80())")
//        }

        let v5: Float64 = 257.35
        ret = ChType.parse("@f64://\(v5)", nil)
        t = ChType.is(ret)
        if let ret = ret as? Float64, let t = t as? ChType {
            print("F64 \(v5):\(t.isSame(ret, v5)) \(t == ChType.f64())")
        }

        let v6: Float32 = 257.35
        ret = ChType.parse("@f32://\(v6)", nil)
        t = ChType.is(v6)
        if let ret = ret as? Float32, let t = t as? ChType {
            print("F32 \(v6):\(ret == v6) \(t == ChType.f32())")
        }



//        ret = ChType.parse("@i://123456789012345", nil)
//        t = ChType.is(123456789012345)
//        if let ret = ret as? Int64, let t = t as? ChType {
//            print("I i64:\(ret == 123456789012345) \(t == ChType.i())")
//        }
//
//        ret = ChType.parse("@f://3.14", nil)
//        t = ChType.is(3.14)
//        if let ret = ret as? Float, let t = t as? ChType {
//            print("F :\(ret == 3.14) \(t == ChType.f())")
//        }
//
//        ret = ChType.parse("@f://3.141278398569236", nil)
//        t = ChType.is(3.141278398569236)
//        if let ret = ret as? Float80, let t = t as? ChType {
//            print("F f64:\(ret == 3.141278398569236) \(t == ChType.f()) \(ret)")
//        }
//
//        var a: Float64 = 3.1
//
//        print("\(ChType.is(a) == ChType.f())")

		let w = UIWindow()
		w.backgroundColor = UIColor.white
		let router = Router("main")
		router["main"] = {Main()}
		router["sub1"] = {Sub1()}
		router["sub2"] = {Sub2()}
		window = w
		let base = UINavigationController() // UIViewController()
		w.rootViewController = base
        router.route(base, .replace, "replace").with("main")
//        router.route(base, .cover, "sub1").with("sub1")
//        router.route(base, .cover, "sub2").with("sub2")

		w.makeKeyAndVisible()

		return true
	}
}
