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
		let router:Router, base:UIViewController, type:Router.type
		init(_ r:Router, _ b:UIViewController, _ ty:Router.type){
			router = r
			base = b
			type = ty
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
			if let base = base as? UINavigationController{
			}else if let base = base as? UITabBarController{
			}else{
				base.pushRouter(c, type)
			}
		}
	}
	
	static private var router:[String:Router] = [:]
	
	private let table = NSMutableDictionary()
	
	static func get(_ key:String)->Router?{
		return Router.router[key]
	}
	init(_ key:String){
		Router.router[key] = self
	}
	subscript(key:String)->ctrl?{
		get{return table[key] as? ctrl}
		set{table[key] = newValue}
	}	
	func route(_ c:UIViewController, _ t:Router.type)->Routed{
		return Routed(self, c, t)
	}
}
