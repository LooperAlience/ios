//
//  File.swift
//  Empty
//
//  Created by bsidesoft on 2018. 3. 8..
//  Copyright © 2018년 com.bsidesoft.ios. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
	static private let navStack = NSMutableDictionary()
	
	func pushRouter(_ c:UIViewController, _ type:Router.type){
		if UIViewController.navStack[hash] == nil {
			UIViewController.navStack[hash] = NSMutableArray()
		}
		if let stack = UIViewController.navStack[hash] as? NSMutableArray {
			if type == .replace {
				if let c = stack.lastObject as? UIViewController{
					c.removeFromParentViewController()
					c.view.removeFromSuperview()
				}
			}
			stack.add(c)
		}
		addChildViewController(c)
		view.addSubview(c.view)
	}
	func popRouter(){
		if let stack = UIViewController.navStack[hash] as? NSMutableArray {
			if let c = stack.lastObject as? UIViewController{
				stack.removeLastObject()
				c.removeFromParentViewController()
				c.view.removeFromSuperview()
			}
		}
	}
}
