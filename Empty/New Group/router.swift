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
	
	static private var router:[String:Router] = [:]
	
	private var table:[String:ctrl] = [:]
	
	static func get(_ key:String)->Router?{
		return Router.router[key]
	}
	init(_ key:String){
		Router.router[key] = self
	}
	
	subscript(key:String)->ctrl?{
		get{return table[key]}
		set{table[key] = newValue}
	}
	
	func route(_ c:UIViewController, _ k:String, _ t:type){
		if let f = table[k] {
			let sub:UIViewController = f();
			if let c = c as? UINavigationController{
			}else if let c = c as? UITabBarController{
			}else{
				c.pushRouter(sub, t)
			}
		}
	}
}
