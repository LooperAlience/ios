//
//  router.swift
//  Empty
//
//  Created by bsidesoft on 2018. 3. 8..
//  Copyright © 2018년 com.bsidesoft.ios. All rights reserved.
//

import Foundation
import UIKit

class Router{
	typealias ctrl = ()->UIViewController
	public enum type{case add, replace, cover}
	class Routed{
        let router:Router, base:UIViewController, type:Router.type, key: String?
        init(_ r:Router, _ b:UIViewController, _ ty:Router.type, _ k: String?){
			router = r
			base = b
			type = ty
            key = k
		}
		func with(_ k:String){
			if let f = router[k] {
				run(f())
			}
		}
		func with(_ c:UIViewController){
			run(c)
		}
		func with(_ f:ctrl){
			run(f())
		}
		private func run(_ c:UIViewController){
			//viewmodel, ,..
//            if let base = base as? UINavigationController{
//            }else if let base = base as? UITabBarController{
//            }else{
            let idx = base.pushRouter(c, type)
            if let key = key {
                router.keys[key] = idx
            }

//            }
		}
	}
	
	static private var router = NSMutableDictionary()
	
	private let table = NSMutableDictionary()
    let keys = NSMutableDictionary()
	
	static func get(_ key:String)->Router?{
		return Router.router[key] as? Router
	}
	init(_ key:String){
		Router.router[key] = self
	}
	subscript(key:String)->ctrl?{
		get{return table[key] as? ctrl}
		set{table[key] = newValue}
	}

//    router.route(base, Router.type.replace, "????"<-- 이렇게 온다.).with("main")
    func route(_ c:UIViewController, _ t:Router.type, _ k: String?)->Routed{
		return Routed(self, c, t, k)
	}

    func pop(_ c: UIViewController) {
        c.popRouter()
    }

    func remove(_ c: UIViewController, _ k: String) {
        guard let idx = keys[k] as? Int else { return }
        c.removeRouter(idx)
    }
}
