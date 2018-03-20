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

        let stack = (UIViewController.navStack[hash] as? NSMutableArray) ?? NSMutableArray.init()
        UIViewController.navStack[hash] = stack

        switch (self, type) {

        // UINavigationController
        case (let base as UINavigationController, .replace):
            base.viewControllers = base.viewControllers.dropLast() + [c]
            switch stack.count > 0 {
            case true:  stack.replaceObject(at: stack.count - 1, with: c)
            case false: stack.add(c)
            }
        case (let base as UINavigationController, .add):
            base.viewControllers = base.viewControllers + [c]
            stack.add(c)
        case (let base as UINavigationController, .cover): break

        // UIViewController
        case (_, .replace):
            if let c = stack.lastObject as? UIViewController {
                c.removeFromParentViewController()
                c.view.removeFromSuperview()
            }
            fallthrough // [!주의] - 썩 좋은 경험을 선사하지는 않을 가능성이 존재함.
        case (_, .add):
            stack.add(c)
            addChildViewController(c)
            view.addSubview(c.view)
        case (_, .cover): break

        }

	}
	func popRouter(){

        let stack = (UIViewController.navStack[hash] as? NSMutableArray) ?? NSMutableArray.init()
        guard let c = stack.lastObject as? UIViewController else { return }

        stack.remove(c)

        switch (self) {
        case (let base as UINavigationController):
            base.viewControllers = base.viewControllers.dropLast() + []
        default:
            c.removeFromParentViewController()
            c.view.removeFromSuperview()
        }

	}
}
