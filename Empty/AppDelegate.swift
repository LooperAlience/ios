
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

//        let v7: Dictionary = [ ]
        ret = ChType.parse("""
            @map://{
                "a":3,"b":1.5,"c":true,"d": "abc",
                "i0": "@i8://1", "i1": "@i16://2", "i2": "@i32://3", "i3": "@i64://4",
                "f0": "@f32://1.5", "f1": "@f64://2.5",
                "map": "@map://{\\"a\\": 3}"
            }
            """, nil)
        t = ChType.is(ret)
        if let ret = ret as? Dictionary<String, Any>, let t = t as? ChType {
            let map = (ret["map"] as! Dictionary<String, Any>)["a"] as! Int
            print("MAP:\(t == ChType.map())")
            print("""
                ret.a: 3==\(ret["a"]!) \(3 == ret["a"] as! Int)
                ret.b: 1.5==\(ret["b"]!) \(1.5 == ret["b"] as! Float)
                ret.c: true==\(ret["c"]!) \(ChType.is(ret["c"]!) == ChType.b() && ret["c"] as! Bool),
                ret.d: "abc"=="\(ret["d"]!)" \("abc" == ret["d"] as! String)
                ret.i0: 1==\(ret["i0"]!) \(ChType.is(ret["i0"]!) == ChType.i8()) \(ChType.is(ret["i0"]!)) && \(1 == ret["i0"] as! Int8)
                ret.i1: 2==\(ret["i1"]!) \(ChType.is(ret["i1"]!) == ChType.i16()) \(ChType.is(ret["i1"]!)) && \(2 == ret["i1"] as! Int16)
                ret.i2: 3==\(ret["i2"]!) \(ChType.is(ret["i2"]!) == ChType.i32()) \(ChType.is(ret["i2"]!)) && \(3 == ret["i2"] as! Int32)
                ret.i3: 4==\(ret["i3"]!) \(ChType.is(ret["i3"]!) == ChType.i64()) \(ChType.is(ret["i3"]!)) && \(4 == ret["i3"] as! Int64)
                ret.f0: 1.5==\(ret["f0"]!) \(ChType.is(ret["f0"]!) == ChType.f32()) \(ChType.is(ret["f0"]!)) && \(1.5 == ret["f0"] as! Float32)
                ret.f1: 2.5==\(ret["f1"]!) \(ChType.is(ret["f1"]!) == ChType.f64()) \(ChType.is(ret["f1"]!)) && \(2.5 == ret["f1"] as! Float64)
                ret.map.a: 3==\(map) \(ChType.is(map) == ChType.i64()) \(ChType.is(map)) && \(3 == map)
            """)
        }

        ret = ChType.parse("""
            @list://[1, 1.5, true, "abc"]
            """, nil)
        t = ChType.is(ret)
        if let ret = ret as? Array<Any>, let t = t as? ChType {
            print("LIST:\(t == ChType.list())")
            print("""
                ret.0: 1==\(ret[0]) \(1 == ret[0] as! Int)
                ret.1: 1.5==\(ret[1]) \(1.5 == ret[1] as! Float)
                ret.2: true==\(ret[2]) \(ChType.is(ret[2]) == ChType.b() && ret[2] as! Bool),
                ret.3: "abc"=="\(ret[3])" \("abc" == ret[3] as! String)
            """)
        }

        let map = ChMap.init()
        map.set("a", ret!)
           .set("b", """
                    @map://{"a": 3, "b": "abc"}
                    """)
           .set("c", "@{b}")
           .set("d", "@{c.b}")

        if let ret = map.get("a.0") as? Int {
            print("ChMap:")
            print("""
                ret.0: 1==\(ret) \(1 == ret)
                """)
        }

        if let ret = map.get("b.a") as? Int {
            print("ChMap:")
            print("""
                ret.b.a: 3==\(ret) \(3 == ret)
                """)
        }

        if let ret = map.get("b.b") as? String {
            print("ChMap:")
            print("""
                ret.b.b: abc==\(ret) \("abc" == ret)
                """)
        }

        if let ret = map.get("c.b") as? String {
            print("ChMap:")
            print("""
                ret.c.b: abc==\(ret) \("abc" == ret)
                """)
        }

        if let ret = map.get("d") as? String {
            print("ChMap:")
            print("""
                ret.d: abc==\(ret) \("abc" == ret)
                """)
        }

        Ch.set("a", ret!)
        Ch.set("b", """
                    @map://{"a": 3, "b": "abc"}
                    """)
        Ch.set("c", "@{b}")
        Ch.set("d", "@{c.b}")

        if let ret = Ch.get("a.0") as? Int {
            print("Ch:")
            print("""
                ret.0: 1==\(ret) \(1 == ret)
                """)
        }

        if let ret = Ch.get("b.a") as? Int {
            print("Ch:")
            print("""
                ret.b.a: 3==\(ret) \(3 == ret)
                """)
        }

        if let ret = Ch.get("b.b") as? String {
            print("Ch:")
            print("""
                ret.b.b: abc==\(ret) \("abc" == ret)
                """)
        }

        if let ret = Ch.get("c.b") as? String {
            print("Ch:")
            print("""
                ret.c.b: abc==\(ret) \("abc" == ret)
                """)
        }

        if let ret = Ch.s("d") {
            print("Ch:")
            print("""
                ret.d: abc==\(ret) \("abc" == ret)
                """)
        }

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

        let red = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
        red.backgroundColor = UIColor.red
        window?.addSubview(red)
        let looper1 = ChLooper.init(red)
        window?.addSubview(looper1)


		return true
	}
}

extension Ch {
    class func s(_ str: String) -> String? {
        return Ch.get(str) as? String
    }
//    class func s(_ args: CVarArgType...) -> Any {
//        getVaList(args)
//    }
}
